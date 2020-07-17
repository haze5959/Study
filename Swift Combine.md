# Swift Combine



통신 Publisher 제작과 사용 예제

```swift
let postsDataTaskPublisher = URLSession.shared.dataTaskPublisher(
          for: URL(
              string: “https://jsonplaceholder.typicode.com/posts"
          )!
        )
let commentsDataTaskPublisher = URLSession.shared.dataTaskPublisher(
          for: URL(
             string: “https://jsonplaceholder.typicode.com/comments"
          )!
        )
let postsPublisher = postsDataTaskPublisher
     .retry(2)
     .map(\.data)
     .decode(type: [Post].self, decoder: JSONDecoder())
     .replaceError(with: [])
let commentsPublisher = commentsDataTaskPublisher
    .retry(2)
    .map(\.data)
    .decode(type: [Comment].self, decoder: JSONDecoder())
    .replaceError(with: [])
Publishers.CombineLatest(postsPublisher, commentsPublisher)
     .sink { posts, comments in
          print(“There are \(posts.count) posts”)
          print(“There are \(comments.count) comments”)
     }
     .store(in: &subscriptions)
// prints There are 100 posts
// prints There are 500 comments
```



통신 Publisher 구독 관련 간단 예제

```swift
dataTaskPublisher
    .retry(2)
    .map(\.data)
    .decode(type: [Post].self, decoder: JSONDecoder())
    .replaceError(with: [])
    .receive(on: DispatchQueue.main)
    .sink { posts in
        print("There are \(posts.count) posts")
    }
    .store(in: &subscriptions)
```

Error Handling

```swift
enum HTTPError: LocalizedError {
    case statusCode
}

self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
.tryMap { output in
    guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
        throw HTTPError.statusCode
    }
    return output.data
}
.decode(type: [Post].self, decoder: JSONDecoder())
.eraseToAnyPublisher()
.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        break
    case .failure(let error):
        fatalError(error.localizedDescription)
    }
}, receiveValue: { posts in
    print(posts.count)
})
```

#### Zip

```swift
let url1 = URL(string: "https://jsonplaceholder.typicode.com/posts")!
let url2 = URL(string: "https://jsonplaceholder.typicode.com/todos")!

let publisher1 = URLSession.shared.dataTaskPublisher(for: url1)
.map { $0.data }
.decode(type: [Post].self, decoder: JSONDecoder())

let publisher2 = URLSession.shared.dataTaskPublisher(for: url2)
.map { $0.data }
.decode(type: [Todo].self, decoder: JSONDecoder())

self.cancellable = Publishers.Zip(publisher1, publisher2)
.eraseToAnyPublisher()
.catch { _ in
    Just(([], []))
}
.sink(receiveValue: { posts, todos in
    print(posts.count)
    print(todos.count)
})
```

#### FlatMap으로 두개의 통신 이어주기

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    let url1 = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    self.cancellable = URLSession.shared.dataTaskPublisher(for: url1)
    .map { $0.data }
    .decode(type: [Post].self, decoder: JSONDecoder())
    .tryMap { posts in
        guard let id = posts.first?.id else {
            throw HTTPError.post
        }
        return id
    }
    .flatMap { id in
        return self.details(for: id)
    }
    .sink(receiveCompletion: { completion in

    }) { post in
        print(post.title)
    }
}

func details(for id: Int) -> AnyPublisher<Post, Error> {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { $0 as Error }
        .map { $0.data }
        .decode(type: Post.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}
```



### Timer Snippet

```swift
var cancellable: AnyCancellable?
// start automatically
cancellable = Timer.publish(every: 1, on: .main, in: .default)
.autoconnect()
.sink {
    print($0)
}

// start manually
let timerPublisher = Timer.publish(every: 1.0, on: RunLoop.main, in: .default)
cancellable = timerPublisher
.sink {
    print($0)
}
// start publishing time
let cancellableTimerPublisher = timerPublisher.connect()
// stop publishing time
//cancellableTimerPublisher.cancel()

// cancel subscription
//cancellable?.cancel()
```



### Notification Snippet

```swift
extension Notification.Name {
    static let example = Notification.Name("example")
}

class ViewController: UIViewController {
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancellable = NotificationCenter.Publisher(center: .default, 
                                                        name: .example, 
                                                        object: nil)
        .sink { notification in
            print(notification)
        }
        
        //post notification
        NotificationCenter.default.post(name: .example, object: nil)
    }
}
```



### Published variables

```swift

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    @Published var labelValue: String? = "Click the button!"	//양방향 바인딩
    
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cancellable = self.$labelValue.receive(on: DispatchQueue.main)
                                           .assign(to: \.text, on: self.textLabel)
    }
    
    @IBAction func actionButtonTouched(_ sender: UIButton) {
        self.labelValue = "Hello World!"
    }
}
```



### Subject

```swift
let subject = PassthroughSubject<String, Never>()

let anyCancellable = subject
.sink { value in
    print(value)
}

// sending values to the subject
subject.send("Hello")

// subscribe a subject to a publisher
let publisher = Just("world!")
publisher.subscribe(subject)

anyCancellable.cancel()


// sending errors
enum SubjectError: LocalizedError {
    case unknown
}
let errorSubject = PassthroughSubject<String, Error>()
errorSubject.send(completion: .failure(SubjectError.unknown))

//Subject를 이용한 위치정보 가져오기
class LocationPublisher: NSObject {
    let subject = PassthroughSubject<[CLLocation], Error>()
    //...
}

extension LocationPublisher: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.subject.send(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.subject.send(completion: .failure(error))
    }
}
```



### Future and Promise

```swift
func asyncMethod(completion: ((String) -> Void)) {
    //...
}

func promisifiedAsyncMethod() -> AnyPublisher<String, Never> {
    Future<String, Never> { promise in
        asyncMethod { value in
            promise(.success(value))
        }
    }
    .eraseToAnyPublisher()
}
```



### Just

```swift
//값을 제공하고 메모리상에서 제거된다.
//디폴트값을 지정하거나 단순 값을 리턴받고 싶을때 사용된다.
let just = Just<String>("just a value")
    
just.sink(receiveCompletion: { _ in
    
}) { value in
    print(value)
}
```



### Scheduler

```swift
//1초 딜레이 후 값 리턴
return Future<String, Error> { promise in
    promise(.success("example"))
}
.delay(for: .init(1), scheduler: RunLoop.main)
.eraseToAnyPublisher()
```



### Error Handler

```swift
// error handling in sink
errorPublisher
.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        break
    case .failure(let error):
        fatalError(error.localizedDescription)
    }
}, receiveValue: { value in
    print(value)
})


// mapError, catch
_ = Future<String, Error> { promise in
    promise(.failure(NSError(domain: "", code: 0, userInfo: nil)))
}
.mapError { error in
    //transform the error if needed
    return error
}
.catch { error in
    Just("fallback")
}
.sink(receiveCompletion: { _ in
    
}, receiveValue: { value in
    print(value)
})
```



### Debugging

```swift
// handle events
.handleEvents(receiveSubscription: { subscription in
    
}, receiveOutput: { output in
    
}, receiveCompletion: { completion in
    
}, receiveCancel: {
    
}, receiveRequest: { request in
    
})

// breakpoints
.breakpoint()
.breakpoint(receiveSubscription: { subscription in
    true
}, receiveOutput: { output in
    true
}, receiveCompletion: { completion in
    true
})
.breakpointOnError()
```



#### Custom Combine Publisher

https://www.avanderlee.com/swift/custom-combine-publisher/