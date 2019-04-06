# Swift Error Handling

#### 커스텀 에러 정의

```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
```



#### 커스텀 에러 핸들링(throwing function)

```swift
func vend(itemNamed name: String) throws {
    guard let item = inventory[name] else {
        throw VendingMachineError.invalidSelection
    }

    guard item.count > 0 else {
        throw VendingMachineError.outOfStock
    }

    guard item.price <= coinsDeposited else {
        throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
    }

    coinsDeposited -= item.price

    var newItem = item
    newItem.count -= 1
    inventory[name] = newItem

    print("Dispensing \(name)")
}
```



#### 에러 메서드 호출할 때 사용하는 try

```swift
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
```



#### do~catch

```swift
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

```



#### try?: 에러가 나면 null return

```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

//try! 이건 보는 그대로 옵셔널을 언랩핑하는 것임. 에러 떨어지면 크래시나서 왠만해서는 쓰면 안됨
```

