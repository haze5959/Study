# Swift

### 기본 문법

```
let - 상수선언
var - 변수선언
```

```swift
변수 초기화 방법(선언과 초기화를 따로할 경우 타입을 지정해 줘야한다.)
var company : String
company = "Apple"

//for-in Index 사용하기!!
for (index, element:myTask) in self.taskData.enumerated() {
}
```

- 타입변환

```swift
var grade = "Your grade is "
var gradePoint = 99
var gradeTotal = grade + String(gradePoint)
```

- 문자열 템플릿

```swift
let profile = “\(name)님은 \(birthDay)일이 생일입니다.”
```

- 배열

```swift
var 배열명 = ["첫번째", "두번째"] 
//배열 선언(둘이 같음)
let apps = Array<String>()
let apps = [String]()
```

- 딕셔너리

```swift
var responseMessages = [200: "OK",
                      403: "Access forbidden",
                      404: "File not found",
                      500: "Internal server error"]
                      
let httpResponseCodes = [200, 403, 301]
for code in httpResponseCodes {
    if let message = responseMessages[code] {
        print("Response \(code): \(message)")
    } else {
        print("Unknown response \(code)")
    }
}                    
                      
var emptyDict: [String: String] = [:]
```

- 함수

```swift
func call(value:Int=333) -> String {
    print(value)
    return "OK"
}
print(call(111)) // OK
print(call()) // OK

//파라미터 이름 생략
func hello(_ name: String, time: Int) {
  // ...
}
hello("전수열", time: 3) // 'name:' 이 생략되었습니다.

//개수가 정해지지 않은 파라미터
func sum(_ numbers: Int...) -> Int {
  var sum = 0
  for number in numbers {
    sum += number
  }
  return sum
}
sum(1, 2)
sum(3, 4, 5)
```

- 타입 

```swift
//어떤 타입이든 변신 가능한 Any, AnyObject
let anyNumber: Any = 10
let anyString: Any = "Hi"
let anyInstance: AnyObject = Dog()

//Any를 더 작은 범위로 줄이는 다운 캐스팅
let number: Int? = anyNumber as? Int

//타입 검사
print(anyNumber is Any)    // true
print(anyNumber is String) // false
```



### 튜플

```swift
func get() -> (result1:String, result2:Int) {
    return ("AAA", 111) // 튜플로 반환
}
var tup = get()
print(tup.result1, tup.result2) // AAA 111
```



### 로그

```swift
Literal        Type     Value

#file          String   The name of the file in which it appears.
#line          Int      The line number on which it appears.
#column        Int      The column number in which it begins.
#function      String   The name of the declaration in which it appears.
#dsohandle     String   The dso handle.

print("# \(#function)")

//프린트 함수 익스텐션
func print(debug: Any = "", function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
        var filename: NSString = file as NSString
        filename = filename.lastPathComponent as NSString
        Swift.print("파일: \(filename), 라인: \(line), 함수: \(function) \n\(debug)")
    #endif
}
```



### 클로저

```swift
// 클로져 (함수의 'func sumFunc' 빼고, in 추가)
var sumClosure = {(a, b) -> Int in return a + b}
print(sumClosure(1, 2))

//함수안의 함수
func helloGenerator(message: String) -> (String, String) -> String {swift
  return { $1 + $0 + message }
}

//클로저 활용
let arr1 = [1, 3, 6, 2, 7, 9]
let arr2 = arr1.map { $0 * 2 } // [2, 6, 12, 4, 14, 18]


func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
```



#### @escaping 예시

```swift
// 함수 외부에 클로저를 저장하는 예시 
// 클로저를 저장하는 배열 
var completionHandlers: [() -> Void] = [] 
func withEscaping(completion: @escaping () -> Void) { 
// 함수 밖에 있는 completionHandlers 배열에 해당 클로저를 저장 	
	completionHandlers.append(completion) 
} 

func withoutEscaping(completion: () -> Void) { 
	completion() 
}

class MyClass { 
	var x = 10 
	func callFunc() { 
		withEscaping { self.x = 100 } 
		withoutEscaping { x = 200 } 
	} 
} 
let mc = MyClass() 
mc.callFunc() 
print(mc.x) 
completionHandlers.first?() 
print(mc.x) 
// 결과 
// 200 
// 100
```



### Getter Setter

```swift
var _v:Int = 0
var value:Int {
    get {//oldValue 값도 쓸 수 있음
        return _v
    }
    set {
        _v = newValue
        print("_v=\(_v)") //_v=10
    }
    didSet {	//willSet 도 있음
        switch (value) {
            case 0:
            case 2:
            default:
            	break;
        }
    }
}

print(value) // 0
value = 10
```



### guard 사용법

```swift
가드문에 걸리면 그 안의 조건문이 실행된다! 말그대로 가드!
var myVar = 10

func checkNumGuard(X:Int?) {
    guard let X = X where X != 10 else {
        print("Error: X is 10!")
        return
    }
    print ("all this code will be executed when X is not 10")
}
 
checkNumGuard(myVar) // 출력: Error: X is 10!
```



### Struct    

```swift
struct Sample {
    // 가변 프로퍼티
    var mutableProperty: Int = 100
    // 불변 프로퍼티
    let immutableProperty: Int = 100

    // 타입 프로퍼티
    static var typeProperty: Int = 100

    // 인스턴스 메서드
    func instanceMethod() {
        print("instance method")
    }

    // 타입 메서드
    static func typeMethod() {
        print("type method")
    }
    
    // 키워드도 `로 묶어주면 이름으로 사용할 수 있습니다
    var `class`: String = "Swift"
    // 가변 프로퍼티
    var name: String = "unknown"
    
    func selfIntroduce() {
        print("저는 \(self.class)반 \(name)입니다")
    }
}
```


### class

```swift
class Person {
    // 프로퍼티
    class var mom:String {
        get {
            return "Mommy"
        }
    }
    var name:String	//옵셔널도 아닌것이 초기화도 안한다면 에러가 난다
    var age:Int


// 생성자 (초기화)
init() {
    self.name = "none"
    self.age = 0
}

// 생성자 오버로딩
init(name:String, age:Int) {
    self.name = name
    self.age = age
}

// 메소드
func sing() -> Void {
    print("Let it go~")
}


}

print(Person.mom)
var p1 = Person(name:"Elsa", age:21)
p1.sing()

// 상속
class Anna : Person {
    override func sing() {
        print("Love is an open door~")
    }
}

var anna = Anna(name: "Anna", age: 18)
anna.sing()
```



### Enum

```swift
enum Month: Int {
  case january = 1
  case february
	쭉쭉
  case november
  case december

  func simpleDescription() -> String {
    switch self {
    case .january:
      return "1월"
    case .february:
      return "2월"
    쭉쭉
    case .november:
      return "11월"
    case .december:
      return "12월"
    }
  }
}

let december = Month.december
print(december.simpleDescription()) // 12월
print(december.rawValue)            // 12
let october = Month(rawValue: 10)
print(october) 			// Optional(Month.october)

//옵셔널은 Enum 이었다!!
public enum Optional<Wrapped> {
  case none
  case some(Wrapped)
}

//사용법
let age: Int? = 20

switch age {
case .none: // `nil`인 경우
  print("나이 정보가 없습니다.")

case .some(let x) where x < 20:
  print("청소년")

case .some(let x) where x < 65:
  print("성인")

default:
  print("어르신")
}
```



### Extension

```swift
//카테고리 같은거임
extension String {
  var length: Int {
    return self.characters.count
  }

  func reversed() -> String {
    return self.characters.reversed().map { String($0) }.joined(separator: "")
  }
}

let str = "안녕하세요"
str.length // 5
str.reversed() // 요세하녕안
```



### 조낸 이상한 문법

```swift
//0~100까지 범위가 맞다면
if 0...100 ~= number {  
  print("result2 = \(number)")
}
```



### convenience initialization

```swift
class Food { 
    var name: String 
    
    init(name: String) { 
        self.name = name 
    } 
    
    convenience init() {
        self.init(name: "[Unnamed]") 
    } 
}
```

![initializersExample01](
​        Study/initializersExample01_2x.png
​      )



### Codable

클래스나 구조체를 JSON으로 인코딩 디코딩 간편하게 해주기 위한것으로

클래스 인스턴스를 NSUserDefault 같은 곳에 저장할 때 유용하다!

```swift
//구조체를 NSUserDefault에 저장하고 빼내는 예제
struct Person: Codable {
    var name: String
}

let taylor = Person(name: "Taylor Swift")

//인코딩
let encoder = JSONEncoder()
if let encoded = try? encoder.encode(taylor) {
    let defaults = UserDefaults.standard
    defaults.set(encoded, forKey: "SavedPerson")
}

//디코딩
if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
    let decoder = JSONDecoder()
    if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
        print(loadedPerson.name)
    }
}

//JSONEncoder 대신 PropertyListEncoder를 사용하여 plist로 관리할 수 있다.
```



### NSLayoutAnchor

```swift
NSLayoutConstraint(item: subview, attribute: .Leading,
                   relatedBy: .Equal,
                   toItem: view,
                   attribute: .LeadingMargin,
                   multiplier: 1.0,
                   constant: 0.0).active = true

NSLayoutConstraint(item: subview,
                   attribute: .Trailing,
                   relatedBy: .Equal,
                   toItem: view,
                   attribute: .TrailingMargin,
                   multiplier: 1.0,
                   constant: 0.0).active = true 

// 위와 아래가 같다!! iOS9부터 사용 가능!
// Creating the same constraints using Layout Anchors 
let margins = view.layoutMarginsGuide subview.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true subview.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true

//가운데 정렬
indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

//가로 세로 값 넣기
containerView.widthAnchor.constraintLessThanOrEqualToConstant(320.0).active = true
```
