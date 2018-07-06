# Swift GCD

스레드 큐 돌리기

```swift
//임의의 큐
DispatchQueue(label: "kr.swifter.app.queue").async {	
   selft.doSomething()
}

//메인 큐
DispatchQueue.main.async {
  self.doSomething()
}

//시스템에서 준비된 큐
DispatchQueue.global(qos: .default).async {
   self.doSomething()
}

QoS의 우선순위는 다음과 같다(위에서 아래로~)
userInteractive
userInitiated
default
utility
background
unspecified
```



지정한 시간 후 처리

```swift
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10)) {
   self.doSomething()
}
```



모든 큐 처리 끝나면 특정작업 실행

```swift
let g = DispatchGroup()
let q1 = DispatchQueue(label: "kr.swifter.app.queue1")
let q2 = DispatchQueue(label: "kr.swifter.app.queue2")
let q3 = DispatchQueue(label: "kr.swifter.app.queue3")

q1.async(group: g) {
   print("queue1 완료")
}

q2.async(group: g) {
   print("queue2 완료")
}

q3.async(group: g) {
   print("queue3 완료")
}

g.notify(queue: DispatchQueue.main) {
   print("전체 작업완료")
}
```

