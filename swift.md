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

for문
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



# RxSwift

- 함수형의 간단 명료 정의

  “대입문 없이 프로그래밍 하는 것!”

- 장점

  - 사이드 이팩트 없다 => 변수를 저장해두고 써먹는게 아니라 함수식으로 그때그때 써먹으니 
  - 스레드세이프 하다
  - 생산성이 높아진다, 코드가 간결해진다.

- 기본 문법

  ```swift
  - let data = [“1”, “2”, “3”, “4”, “5”, “6”]
    				.map({ (item) -> Int in
    					guard let value = Int(item) else { return 0 }
    					return value
    				})
    				,filter({ (value) -> Bool in
    					return value % 2 == 0
    				})
    				, reduce(0) { (a, b) -> Int in
    					return a + b
    				}
  
  //1부터 10까지 더하기
  print( (1…10).reduce(0){$0 + $1} );
  
  //조낸 줄이기
  (1…10)
  .filter{
  	$0 % 2 == 0 //2, 4, 6, 8, 10
  }.map{
  	$0 * 10	//20, 40, 60, 80, 100
  }.reduce(0){
  	$0 + $1	//300
  }
  ```

- 옵져버블 기본

```swift
Observable.just(“Helllo World!”)
		.subscribeNext{ value in
				print(value);
		}.addDisposableTo(bag);

//순차적 진행
Observable.create<String>{ observer in
	observer.onNext(“1”)
	observer.onNext(“2”)
	observer.onNext(“3”)
	observer.onNext(“4”)
	observer.onCompleted()
}.subscribe{
	print($0);	//1 2 3 4
}
```

- 옵져버블 옵션

```swift
//중복 값 제거
.distinctUntilChanged()

//다처리하고 들가라
.combineLatest(idObservable, pwObservable){return $0, $1}
```

- 로그인 화면 예시

```swift
let idObservable = idTxtField.rx_text.asObservable().map{ $0.isEmpty }
let pwObservable = pwObservable.rx_text.asObservable().map{ $0.isEmpty }
Observable
.combineLatest(idObservable, pwObservable){return $0, $1}
.subscribeNext { tuple in
	let buttonTitle:String = {
		switch tuple {
		case (true, true): return “아디/비번 입력해라”
		case (true, _): return “아디 입력해라”
		case (_, true): return “비번 입력해라”
		default : return “로그인 고고”
		}
	()}
}.addDisposableTo(disposeBag);
```

- 옵져버블 동시처리

```swift
//zip은 두개가 모두 처리될 때까지 기다린다.
let Observable1 = (0…100000)
			.toObservable()
			.reduce(0, accumulator: {(x, y) -> Int in
				return x + y
			});

let Observable2 = Observable.just(“Sum”);

Observable.zip(Observable1, Observable2){ (sum: Int, text: String) -> String in
		return “\(text): \(sum)”}
		.subscribeNext { value in
			print(value);}
		.addDisposableTo(bag)

print(“hello?”);
//위의 로직은 메인쓰레드에서 돌기 때문에 hello?가 늦게 출력된다.
이를 해결하기 위해 아래와 같이 바꿔준다.

Observable.zip(Observable1, Observable2){ (sum: Int, text: String) -> String in
		return “\(text): \(sum)”}
		.subscribeOn(backgroundScheduler)
		.subscribeNext { value in
			print(value);}
		.addDisposableTo(bag)

//subscribeOn은 subscribe가 이루어지는 쓰레드를 지정하는 것
//다만 UI작업을 subscribe에서 처리할 경우 메인쓰레드에서 이루어져야 하는데 그럴경우 .observeOn(MainScheduler.instance)를 subscribeOn 밑에다 추가해준다
```

Observable 제공 기능들! 

오리엔테이션 변경 - UIDevice.rx.orientation

노티피케이션을 옵져버블로 변경 - NotificationCenter.default.addObserver(forName:.UIKeyboardDidChangeFrame){noti in 핸들링~}



### RXSwift  UI Event

```swift
button.rx.tap
.debounce(0.5, scheduler:MainScheduler.instance)	//0.5초 동안 여러번 눌리지 않게
.do(onNext: {	
    print("눌렸다!!")
})
.bindNext(method)
.addDisposableTo(disposeBag)
```



### RXSwift  REST API

```swift
API.default.request(.getPage)	//Observable<JSON>
.subscribeOn(SerialDispatchQueueScheduler(qos: .backgound))	//백그라운드에서 수행
.retry(2)	//실패했을 경우 2번까지 수행한다
.observeOn(ConcurrentDispatchQueueScheduler(qos: .backgound))	//결과 맵핑등을 백그라운드에서 수행
.map(Page.init)	//Observable<Page>
.observeOn(MainScheduler.instance)	//UI는 메인스레드에서 그릴 수 있도록
.do(
    onNext: {	print("성공!!: \($0)")},
    onError: {	print("실패!!": \(error))},
    onCompleted: {	print("완료!!")}
)
.bindNext(display)
.addDisposableTo(disposeBag)
```



### RXSwift  Property Binding

```swift
let isReloading: Variable<Bool> = Variable(false)

func setup() {
    isReloading.asObservable()
    .map { !$0 }
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: {[weak self] enabled in
                       self?.reloadButton.isEnabled = enabled
                       })
    // == bindTo(reloadButton.rx.isEnabled)
    .addDisposableTo(disposeBag)
}
```



### RXSwift  Merge Operator

둘 중에 하나만 발생해도 이밴트 호출

```swift
Observable.from([
    옵저버블.map{!$0},
    버튼.rx.tap
]).merge()
.bindTo(쏼라쏼라...)
```



### RXSwift Operator and so on...

```swift
Observable()	//-f-t-f-t-f-t-f
.filter { $0 == false }	//-f-_-f-_-f-_-f
.skip(1)	//-_-_-f-_-f-_-f
.take(1)	//-_-_-f
```



# 코딩 테스트 자주 사용

```swift
var input = Int(readLine()!)!	//값 입력!

let stringArray = readLine(strippingNewline: true)!.characters
.split {$0 == ” “}
.map (String.init)

let people = ["yagom": 10, "eric": 15, "mike": 12]

// Dictionary의 item은 key와 value로 구성된 튜플 타입입니다
for (name, age) in people {
    print("\(name): \(age)")
}

for i in (0..<10).reverse() {
    //거꾸로
}
```



#### 약수 구하기

```swift
var input = Int(readLine()!)!
var resultArr = [String]()

for i in 1..<(input+1) {
    if input % i == 0 {
        resultArr.append("\(i)")
    }
}

print(resultArr.joined(separator: " "))
```



#### 정렬 후 최소 빈 최소값 구하기

```swift
public func solution(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var ministNum = 1
    A = A.sorted(by: { $0 < $1})//정렬 노필요ㅋㅋㅋㅋ

    for i in 0...A.count {
        // print("test: \(ministNum)")
        for element in A {
            if ministNum == element {
                ministNum += 1
                break;
            }
        }
    }

    return ministNum
}
```


```swift
import UIKit

//없는 작은값 찾기
public func solution(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)

    var ministNum = 1
//    A = A.sorted(by: { $0 < $1})

    for i in 0...A.count {
        print("test: \(ministNum)")
        for element in A {
            if ministNum == element {
                ministNum += 1
                break;
            }
        }
    }

    return ministNum
}

var test = [2, 5, 1, 3, 7]

print(solution(&test))


//=========================================================================
//2진수를 그 뭐냐..
public func solution(_ S : inout String) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var step = 0

    let d2Optional = Int(S, radix: 2)

    guard var d2 = d2Optional else { return -1 }    //예외 상황

    while d2 > 0 {
        print(d2)
        if d2 % 2 == 0 {    //짝수
            d2 = d2 / 2
        } else {    //홀수
            d2 = d2 - 1
        }

        step += 1
    }

    return step
}

var test = "011100"

print(solution(&test))


//=========================================================================
//이미지 리네임 문제
public func solution(_ S : inout String) -> String {
    // write your code in Swift 4.2.1 (Linux)

    //지역 개수 구하기
    var areaTimeDic: [String: Array<String>]  = [:]

    let fileArr = S.split(separator: "\n")


    for line in fileArr {

        //예외처리 부분
        let argArr = line.split(separator: ",")
        guard argArr.count > 2 else { break }

        let area = argArr[1].decomposedStringWithCanonicalMapping.trimmingCharacters(in: .whitespacesAndNewlines)

        let areaTimeArr = areaTimeDic[area]
        if  areaTimeArr != nil {
            var areaTimeArr = areaTimeDic[area]!
            areaTimeArr.append(argArr[2].decomposedStringWithCanonicalMapping.trimmingCharacters(in: .whitespacesAndNewlines))
            areaTimeDic.updateValue(areaTimeArr, forKey: area)
        } else {    //최초 도시일 경우
            let newAreaArr = [argArr[2].decomposedStringWithCanonicalMapping.trimmingCharacters(in: .whitespacesAndNewlines)]
            areaTimeDic.updateValue(newAreaArr, forKey: area)
        }
    }

//    print(areaTimeDic)
    //결과 도출 부분
    var resultArr = [String]()
    var areaNumDic: [String: Int]  = [:]
    for line in fileArr {
        //예외처리 부분
        let argArr = line.split(separator: ",")
        guard argArr.count > 2 else { break }


        let fileName = argArr[0].decomposedStringWithCanonicalMapping
        guard let fileExtention = fileName.split(separator: ".").last else { break }
        let area = argArr[1].decomposedStringWithCanonicalMapping.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let areaTimeArr = areaTimeDic[area] else { break }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let index = areaNumDic[area] ?? 0
        let areaTime = areaTimeArr[index]
        let thisAreaTime = dateFormatter.date(from: areaTime)

        var seq = 1
        for areaTime in areaTimeArr {
            let time = dateFormatter.date(from: areaTime)

            if thisAreaTime!.timeIntervalSince1970 > time!.timeIntervalSince1970 {
                seq += 1
            }
        }

        if let areaNum = areaNumDic[area] {
            areaNumDic.updateValue((areaNum + 1), forKey: area)
        } else {
            areaNumDic.updateValue(1, forKey: area)
        }

        let areaCount = areaTimeArr.count
        if areaCount >= 10 {
            resultArr.append("\(area)\(String(format: "%02d", seq)).\(fileExtention)")
        } else {
            resultArr.append("\(area)\(seq).\(fileExtention)")
        }

    }

    return resultArr.joined(separator: "\n")
}


var test = """
photo.jpg, Warsaw, 2013-09-05 14:08:15
john.png, London, 2015-06-20 15:13:22
myFriends.png, Warsaw, 2013-09-05 14:07:13
Eiffel.jpg, Paris, 2015-07-23 08:03:02
pisatower.jpg, Paris, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Paris, 2015-09-01 12:00:00
me.jpg, Warsaw, 2013-09-06 15:40:22
a.png, Warsaw, 2016-02-13 13:33:50
b.jpg, Warsaw, 2016-01-02 15:12:22
c.jpg, Warsaw, 2016-01-02 14:34:30
d.jpg, Warsaw, 2016-01-02 15:15:01
e.png, Warsaw, 2016-01-02 09:49:09
f.png, Warsaw, 2016-01-02 10:55:32
g.jpg, Warsaw, 2016-02-29 22:13:11
"""

print(solution(&test))

//=========================================================================
//엘레베이터 몇번 멈추냐 문제

public func solution(_ A : inout [Int], _ B : inout [Int], _ M : Int, _ X : Int, _ Y : Int) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var result = 0
    
    while !A.isEmpty {
//        print(A)
        var allWeight = 0
        var takePeople = 0
        for weight in A {
            if (allWeight + weight) > Y {   //무게 제한
                break
            }
            
            if takePeople > X { //탑승인원 제한
                break
            }
            
            allWeight += weight
            takePeople += 1
        }
        
//        print("weight:\(allWeight)")
//        print("takePeople:\(takePeople)")
        
        var floors = Set<Int>()   //중복층수 제거를 위해 set tkdyd
        
        for i in 0..<takePeople {
            floors.insert((B[0]))
            A.removeFirst() //내린 사람들 삭제
            B.removeFirst()
        }
        
//        print("floors:\(floors)")
        
        result += floors.count
//        print("result:\(result)")
    }

    return result
}

var A = [40, 40, 100, 80, 20]
var B = [3, 3, 2, 2, 3]


print(solution(&A, &B, 3, 5, 200))

```



#### 사각형 크기 구하기

```swift
if let valuesStr = readLine() {
  
  let valueArr = valuesStr.split(separator: " ")

  if valueArr.count == 2 {
      let a:Int! = Int(valueArr[0]) // firstText is UITextField
      let b:Int! = Int(valueArr[1]) // secondText is UITextField
      let resultVal = a * b
      print("\(resultVal)")
  } else {
      print("Invalid value")
  }
}
```



#### 커멘드로 움직이는 큐 구현하기

```swift
var maxCommandNum = 0
var commandNum = 0
var capacity = 0

var que = [Substring]()

func excuteComment(_ commendArr:Array<Substring>) -> String {
  let commend = commendArr[0]
  if commend == "OFFER" {
      if commandNum < capacity {
          if commendArr.count == 2 {
              let inputVal = commendArr[1]
              que.append(inputVal)
              return "true"
          } else {
              return "false"
          }
      } else {
          return "false"
      }

  } else if commend == "TAKE" {
    return "\(que.remove(at: 0))"
  } else if commend == "SIZE" {
    return "\(capacity)"
  } else {
      return "false"
  }
}

if let input1 = readLine() {
  let valueArr = input1.split(separator: " ")
  if valueArr.count == 2 {
    maxCommandNum = Int(valueArr[0])!
    capacity = Int(valueArr[1])!
    
    while maxCommandNum > commandNum {
      if let input = readLine() {
        let valueArr = input.split(separator: " ")
        print(excuteComment(valueArr))
        commandNum += 1
      }
    }
  }
}


```

