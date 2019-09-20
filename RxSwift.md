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
Observable<String>.create{ observer in
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



### RXSwift  Property Binding (Depricated)

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



### BehaviorRelay (Variable 대안)

PublishRelay와 차이점은 구독이 생겼을 때 기존 이벤트를 실행시키냐 안시키냐의 차이

```swift
print("===============================")
print("\n\n")

let subject = BehaviorRelay(value: "Default String")

// value : get-only-property
print("value print : \(subject.value)")

subject.accept("A") // 안나옴
subject.accept("B")

subject.asObservable()
    .subscribe(onNext: { text in
        print(text)
    }).disposed(by: disposeBag)
subject.accept("C")
subject.accept("D (Last)")

subject.asObservable()
    .subscribe(onNext: { text in
        print(text)
    }).disposed(by: disposeBag)

subject.accept("E")
subject.accept("F")
subject.accept("G")

print("===============================")

value print : Default String
B
C
D (Last)
D (Last)
E
E
F
F
G
G
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



### throttle과 debounce 차이점

`_.debounce`는 `_.throttle`과 마찬가지로 과다한 이벤트 로직 실행을 방지하기 위해 사용되는 함수이다. 
바로 실행되는 `_.throttle`과는 달리 호출이 반복되는 동안에는 로직 실행을 방지하며, 호출이 멈춘 뒤, 설정한 시간이 지나고 나서야 로직을 실행하게 된다.
주의점: 해당 시간동안 같은 스케쥴러의 모든 구독들이 실행 방지된다.



### reduce와 scan 차이점

reduce는 합쳐지는 값을 한번에 리턴
scan은 합쳐지는 동중의 값을 매번 리턴

```swift
// 1부터 9단 찍기, flatMap 활용
Observable.range(start: 1, count: 9)
        .flatMap { dan in
        Observable.range(start: 1, count: 9).map({ row in
        return "\(dan) * \(row) = \(dan * row)\n"
    }).reduce("\(dan)단 출력\n", accumulator: { "arg1: \($0) arg2: \($1)" })
}
.subscribe(onNext:{ print($0)},
  		   onError:{ print($0) },
  		   onCompleted:{ print("onCompleted")}
)
.disposed(by: disposeBag)
```



### zip, merge, concat 차이점

```swift
let alphabetFromAToE = Observable.from(["a", "b", "c", "d", "e"])
let numberFrom1To5 = Observable.from(["1", "2", "3", "4", "5"])

//combineLatest와 다른점은 두값다 안들어와도 구독된다
Observable.zip(alphabetFromAToE, numberFrom1To5)
.subscribe(onNext:{ print($0) },
	onError:{ print($0) },
	onCompleted:{ print("onCompleted") })
.disposed(by: disposeBag)

("a", "1")
("b", "2")
("c", "3")
("d", "4")
("e", "5")

//merge는 둘 중 하나라도 이벤트가 생기면 뿌려준다.
Observable.merge(alphabetFromAToE, numberFrom1To5)
.subscribe(onNext:{ print($0) },
	onError:{ print($0) },
	onCompleted:{ print("onCompleted") })
.disposed(by: disposeBag)

a
1
b
2
c
3
d
4
e
5

//concat은 넣어진 순서대로
Observable.concat(alphabetFromAToE, numberFrom1To5)
.subscribe(onNext:{ print($0) },
	onError:{ print($0) },
	onCompleted:{ print("onCompleted") })
.disposed(by: disposeBag)

a
b
c
d
e
1
2
3
4
5
```



### flatMap

옵져버블에서 발행한 아이템에 다른 옵져버블 아이템들을 붙입니다.

```swift
Observable.from([1,2,3,4])
.flatMap { Observable.from([77]) }
.subscribe(onNext:{print($0)})
.disposed(by: disposeBag)

1
77
2
77
3
77
4
77

//비동기 예제
let t = Observable<Int>
    .interval(0.5, scheduler: MainScheduler.instance)	// 0.5초마다 발행
    .take(4)		// 4번 발행

t.flatMap { (x: Int) -> Observable<Int> in
    let newTimer = Observable<Int>
        .interval(0.2, scheduler: MainScheduler.instance)	// 0.2초마다 발행
        .take(4)		// 4번 발행
        .map { _ in x }		// 전달받은 아이템을 그대로 전달
    return newTimer
    }
    .subscribe {
        print("Result : \($0)")
}

	// Output
	Result : Next(0)
	Result : Next(0)
	Result : Next(0)
	Result : Next(1)
	Result : Next(0)
	Result : Next(1)
	Result : Next(1)
	Result : Next(2)
	Result : Next(1)
	Result : Next(2)
	Result : Next(2)
	Result : Next(3)
	Result : Next(2)
	Result : Next(3)
	Result : Next(3)
	Result : Next(3)
	Result : Completed
```



### flatMapFirst

flatMap에서 한 아이템의 동작이 끝날 때 까지 새로 발행된 아이템을 무시합니다.

```swift
let t = Observable<Int>
    .interval(0.5, scheduler: MainScheduler.instance)	// 0.5초마다 발행
    .take(4)		// 4번 발행

t.flatMapFirst { (x: Int) -> Observable<Int> in
    let newTimer = Observable<Int>
        .interval(0.2, scheduler: MainScheduler.instance)	// 0.2초마다 발행
        .take(4)		// 4번 발행
        .map { _ in x }		// 전달받은 아이템을 그대로 전달
    return newTimer
    }
    .subscribe {
        print("Result : \($0)")
}

	// Output
	Result : Next(0)
	Result : Next(0)
	Result : Next(0)
	Result : Next(0)
	Result : Next(2)
	Result : Next(2)
	Result : Next(2)
	Result : Next(2)
	Result : Completed
```


### flatMapLatest

flatMap에서 한 아이템이 동작 중일 경우 해당 아이템은 Dispose하고 새로운 아이템을 동작시킨다.

```swift
let t = Observable<Int>
    .interval(0.5, scheduler: MainScheduler.instance)	// 0.5초마다 발행
    .take(4)		// 4번 발행

t.flatMapLatest { (x: Int) -> Observable<Int> in
    let newTimer = Observable<Int>
        .interval(0.2, scheduler: MainScheduler.instance)	// 0.2초마다 발행
        .take(4)		// 4번 발행
        .map { _ in x }		// 전달받은 아이템을 그대로 전달
    return newTimer
    }
    .subscribe {
        print("Result : \($0)")
}

	// Output
	Result : Next(0)
	Result : Next(0)
	Result : Next(1)
	Result : Next(1)
	Result : Next(2)
	Result : Next(2)
	Result : Next(3)
	Result : Next(3)
	Result : Next(3)
	Result : Next(3)
	Result : Completed

//좋은 예제 (키보트 칠 때 마다 기존통신 중단시키고 새 통신날리기)
let results = query.rx.text
    .flatMapLatest { query in
        networkRequestAPI(query)
    }
```


### Share

하나의 옵져버블이 여러번 구독될 경우 원치않게 요청을 여러번하지 않게해준다.

```swift
let buttonAction = sendButton.rx.tap
                .do{....}
                .flamap{ _ in 
                    provider.request(.Action)
                        .filter(200)
                        .map(...self)
                        .asObservable()
                }.do{...}


button.subscribe{}// 작업1
button.subscribe{}// 작업2

//이런 경우 리퀘스트가 두번 일어나게 되는데 이때 share()을 써주면 하나의 request를 공유한다.
```

### Driver

옵져버블은 스레드 선택, 에러처리 등을 할 수 있는 방면, Driver는 에러를 발생시키지 않고 자동으로 메인 스레드에 이벤트를 전달한다.
UI에 접목시킬 때 간편!

```swift
lazy var data: Driver<[Repository]> = {
        return Observable.of([Repository]()).asDriver(onErrorJustReturn: [])
    }()
```



#### asDriver asSignal 차이

<img src="files/asDriver asSignal diff.png"/>



## Hot Observable

### PublishSubject

구독을 먼저하고 그 다음에 이벤트를 발생시키는 방식이다.

```swift
let subjectString = PublishSubject<String>()

print("===============================")
print("\n\n")

// frist subscribe
subjectString.subscribe(onNext: { print("string frist: \($0)") },
		onError: { print("string frist: \($0)") },
		onCompleted: { print("string frist: onCompleted") }, onDisposed: { print("string frist: onDisposed")})
	.disposed(by: disposeBag)

subjectString.onNext("1")
subjectString.onNext("2")
subjectString.onNext("안녕하세요.")

// second subscribe
subjectString.subscribe(onNext: { print("string second: \($0)") },
		onError: { print("string second: \($0)") },
		onCompleted: { print("string second: onCompleted") }, onDisposed: { print("string second: onDisposed")})
	.disposed(by: disposeBag)

subjectString.onNext("3")
subjectString.onNext("4")
subjectString.onNext("반갑습니다.")
// subjectString 은 뒤로가기 하면 string: onDisposed 가 호출 될 것 입니다.
print("===============================")

===============================
string frist: 1
string frist: 2
string frist: 안녕하세요.
string frist: 3
string second: 3
string frist: 4
string second: 4
string frist: 반갑습니다.
string second: 반갑습니다.
===============================
```



### ReplaySubject

버퍼만큼 쌓아두고 그 다음 이벤트가 발생하면 버퍼에 쌓아둔 이벤트를 실행
BehaviorSubject는 ReplaySubject에서 버퍼가 1인 것

```swift
// bufferSize 가 0이면 PublicSubject와 똑같습니다.
let bufferSize = 2
print("== bufferSize : \(bufferSize)")
print("===============================")

let subject = ReplaySubject<String>.create(bufferSize: bufferSize)
subject.subscribe(onNext: { print("string frist: \($0)") },
                  onError: { print("string frist: \($0)") },
                  onCompleted: { print("string frist: onCompleted") }, 								  onDisposed: { print("string frist: onDisposed")})
        .disposed(by: disposeBag)
subject.onNext("A")
subject.onNext("B")
subject.onNext("C")
subject.onNext("D")

subject.subscribe(onNext: { print("string second: \($0)") },
                  onError: { print("string second: \($0)") },
                  onCompleted: { print("string second: onCompleted") }, 							  onDisposed: { print("string second: onDisposed")})
    .disposed(by: disposeBag)

subject.onNext("E")
subject.onNext("F")
subject.onNext("G")

print("===============================")

== bufferSize : 2
===============================
string frist: A
string frist: B
string frist: C
string frist: D
string second: C
string second: D
string frist: E
string second: E
string frist: F
string second: F
string frist: G
string second: G
===============================
```



### UIDataBinding

```swift
//이런 식으로 괜히 delegate로 코드 분량 늘리지 않고 바인딩 가능
loadingView.isLoading
	.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
```



### RxAlamofire

```swift
func loginWithSocket(infos: LoginScript) -> Observable<ShopLoginScrapResult> {
        let method = self.getMethod(infos)
        if let mainUrl = infos.mainUrl {
            return RxAlamofire.request(method, mainUrl)
                .validate(statusCode: 200 ..< 300)
                .flatMap({ (_) -> Observable<ShopLoginScrapResult> in
                    return self.socketLogin(infos)
                })
                .retry(3)
                .catchError({ (error) -> Observable<ShopLoginScrapResult> in
                    return Observable.just(.loginFail(shop: self.shop))
                })
                .startWith(.loginStart(shop: self.shop))
        }
        else {
            return socketLogin(infos)
        }
    }
```

