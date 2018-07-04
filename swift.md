# Swift

### 기본 문법

```
let - 상수선언
var - 변수선언
```

```
변수 초기화 방법(선언과 초기화를 따로할 경우 타입을 지정해 줘야한다.)
var company : String
company = "Apple"
```

- 타입변환

```
var grade = "Your grade is "
var gradePoint = 99
var gradeTotal = grade + String(gradePoint)
```

- 문자열 템플릿

```
let profile = “\(name)님은 \(birthDay)일이 생일입니다.”
```

- 배열

```
var 배열명 = ["첫번째", "두번째"] 
//배열 선언(둘이 같음)
let apps = Array<String>()
let apps = [String]()
```

- 딕셔너리

```
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

```
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

```
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

```
func get() -> (result1:String, result2:Int) {
    return ("AAA", 111) // 튜플로 반환
}
var tup = get()
print(tup.result1, tup.result2) // AAA 111
```



### 클로저

```
// 클로져 (함수의 'func sumFunc' 빼고, in 추가)
var sumClosure = {(a, b) -> Int in return a + b}
print(sumClosure(1, 2))

//함수안의 함수
func helloGenerator(message: String) -> (String, String) -> String {
  return { $1 + $0 + message }
}

//클로저 활용
let arr1 = [1, 3, 6, 2, 7, 9]
let arr2 = arr1.map { $0 * 2 } // [2, 6, 12, 4, 14, 18]
```



### Getter Setter

```
var _v:Int = 0
var value:Int {
    get {//oldValue 값도 쓸 수 있음
        return _v
    }
    set {
        _v = newValue
        print("_v=\(_v)") //_v=10
    }
}

print(value) // 0
value = 10
```



### class

```
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

```
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

```
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

```
//0~100까지 범위가 맞다면
if 0...100 ~= number {  
  print("result2 = \(number)")
}
```



# RxSwift

- 함수형의 간단 명료 정의

  “대입문 없이 프로그래밍 하는 것!”

- 장점

  - 사이드 이팩트 없다 => 변수를 저장해두고 써먹는게 아니라 함수식으로 그때그때 써먹으니 
  - 스레드세이프 하다
  - 생산성이 높아진다, 코드가 간결해진다.

- 기본 문법

  ```
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

  ​

- 옵져버블 기본

```
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

```
//중복 값 제거
.distinctUntilChanged()

//다처리하고 들가라
.combineLatest(idObservable, pwObservable){return $0, $1}
```

- 로그인 화면 예시

```
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

```
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

