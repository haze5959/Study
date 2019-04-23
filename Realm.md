# Realm

### model

```swift
//model
class User: Object {
  @objc dynamic var name = ""
  @objc dynamic var pet: Pet?
}

class Pet: Object {
  @objc dynamic var petName = ""
}
```



### Init

```swift
//init
//DB 스킴 나누기
Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3) 
```



### Read

```swift
//read
let realm = try! Realm()
let users = realm.objects(User.self)
```



### Write

```swift
//write
let realm = try! Realm()

let newPet = self.makePetWithName("Cat")
let newUser = self.makeUserWithName("John", pet: newPet)

try! realm.write {
  realm.add(newPet)
  realm.add(newUser)
}
```



### Update

```swift
//update (User에서 첫번째 데이터만 업데이트)
if let user = realm.objects(User.self).first {
   try! realm.write {
      user.name = "James"
      
      if let pet = user.pet
      {
         pet.name = "Jack"
      }
   }
   
   print(realm.objects(User.self).first)
}
```



### Delete

```swift
//delete (첫번째 데이터만 삭제)
if let user = realm.objects(User.self).first {
   try! realm.write {
      realm.delete(user)
   }

   print(realm.objects(User.self))
}
```



### Select

```swift
//select
realm.objects(User.self).filter("name = 'ogyu' AND pet = '\(pet)'").first
```

