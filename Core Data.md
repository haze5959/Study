# Core Data

명확히 sql은 아니지만 sql처럼 사용할 수 있는 앱 내의 RDB



데이터는 이런식으로 가져온다.

```swift
let context = self.persistentContainer.viewContext;
let workSpace = WorkSpace(context: context) // Link Task & Context

let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
//request.predicate = NSPredicate(format: "age = %@", "12")
request.returnsObjectsAsFaults = false
do {
    let result = try context.fetch(request)
    for data in result as! [NSManagedObject] {
        print(data.value(forKey: "username") as! String)
    }

} catch {

    print("Failed")
}
```

