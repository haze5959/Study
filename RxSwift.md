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



### throttle과 debounce 차이점

`_.debounce`는 `_.throttle`과 마찬가지로 과다한 이벤트 로직 실행을 방지하기 위해 사용되는 함수이다. 
바로 실행되는 `_.throttle`과는 달리 호출이 반복되는 동안에는 로직 실행을 방지하며, 호출이 멈춘 뒤, 설정한 시간이 지나고 나서야 로직을 실행하게 된다.



### reduce와 scan 차이점

reduce는 합쳐지는 값을 한번에 리턴
scan은 합쳐지는 동중의 값을 매번 리턴



### zip과 merge 차이점

```swift
let alphabetFromAToE = Observable.from(["a", "b", "c", "d", "e"])
let numberFrom1To5 = Observable.from(["1", "2", "3", "4", "5"])

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
```



### flatMap

옵져버블들을 하나의 이벤트 호라이즌에 쭉 정렬

```swift
Observable.from([1,2,3,4])
.flatMap { Observable.from([$0, 77]) }
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
```



### Driver

옵져버블은 스레드 선택, 에러처리 등을 할 수 있는 방면, Driver는 에러를 발생시키지 않고 자동으로 메인 스레드에 이벤트를 전달한다.
UI에 접목시킬 때 간편!

```swift
lazy var data: Driver<[Repository]> = {
        return Observable.of([Repository]()).asDriver(onErrorJustReturn: [])
    }()
```