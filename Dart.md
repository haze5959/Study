

# Dart

### 변수 선언

```dart
var name = 'Bob';
String name = 'Bob';	//타입 고정

//불변 (const final 차이점은 컴파일타임 전에 값이 정해지냐 아니냐)
final name = 'Bob'; // Without a type annotation
final String nickname = 'Bobby';
const bar = 1000000; // Unit of pressure (dynes/cm2)
const double atm = 1.01325 * bar; // Standard atmosphere
```



### List (array랑 같음) / Set / Map

```dart
var list = [1, 2, 3];
var list2 = [0, ...list];
var list2 = [0, ...?list];	//list가 null일 경우 예외처리

//이런식도 가능
var nav = [
  'Home',
  'Furniture',
  'Plants',
  if (promoActive) 'Outlet'
];

//이런식도
var listOfInts = [1, 2, 3];
var listOfStrings = [
  '#0',
  for (var i in listOfInts) '#$i'
];

//Set 타입은 이런식으로
var elements = <String>{};
elements.add('fluorine');
elements.addAll(halogens);

//Map
var gifts = Map();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var gifts = {'first': 'partridge'};
gifts['fourth'] = 'calling birds'; // Add a key-value pair
```



### String 관련

```dart
// Define a function.
printInteger(int aNumber) {
  print('The number is $aNumber.'); // Print to console.
}
```



### Class

```dart
class Car {  
   // field 
   String engine = "E1001";  
   
   // function 
   void disp() { 
      print(engine); 
   } 
}

var obj = new Car("Engine 1");


// 생성자
void main() {           
   Car c1 = new Car.namedConst('E1001');                                       
   Car c2 = new Car(); 
}           
class Car {                   
   Car() {                           
      print("Non-parameterized constructor invoked");
   }                                   
   Car.namedConst(String engine) { 
      print("The engine is : ${engine}");    
   }                               
}
```



### Async 관련

- async/await 는 js처럼 사용하면 됨

- Future class

  ```dart
  //future 인스턴스에는 두가지 상태가 있음
  //- Uncompleted: 진행 중이거나 실패가 난 상태
  //- Completed: 완료된 상태. Future<T>다음 제네릭에 관련된 타입값을 가진다
  
  String createOrderMessage () {
    var order = getUserOrder(); 
    return 'Your order is: $order';
  }
  
  Future<String> getUserOrder() {
    // Imagine that this function is more complex and slow
    return Future.delayed(Duration(seconds: 4), () => 'Large Latte'); 
  }
  
  main () {
    print(createOrderMessage());
  }
  
  //결과: Your order is: Instance of '_Future<String>'
  ```

- 사용 예

  ```dart
  //타임아웃 구현 방법
  
  Future<void> getUserOrder() {
  // Imagine that this function is fetching user info but encounters a bug
    return Future.delayed(Duration(seconds: 3), () => throw Exception('Logout failed: user ID is invalid'));
  }
  
  main() {
    getUserOrder();
    print('Fetching user order...');
  }
  ```

  ```dart
  // future를 이용한 비동기 리턴
  // Asynchronous
  Future<String> createOrderMessage() async {
    var order = await getUserOrder();
    return 'Your order is: $order';
  }
  
  Future<String> getUserOrder() {
    // Imagine that this function is
    // more complex and slow.
    return
     Future.delayed(
       Duration(seconds: 4), () => 'Large Latte');
  }
  
  // Asynchronous
  main() async {
    print('Fetching user order...');
    print(await createOrderMessage());
  }
  
  // 'Fetching user order...'
  // 'Your order is: Large Latte'
  ```

  