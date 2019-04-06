# iOS Unit Test

#### simple example

```swift
import XCTest
@testable import MyWorkingList

class MyWorkingListTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let result = testUtil.sumArgument(1,2,3)
        XCTAssertEqual(result, 6, "Expectation Value is wrong")
    }
}
```



#### assert

- XCTAssertEqual: 같은 값 판별

- XCTAssert...(nil, true, false, greaterThen...): 각종 판별

- expectation 비동기 테스트 예제 (타임아웃 5초 이내에 통신결과 200이 떨어지냐)

  ```swift
  let url = URL(string: "https://itune.apple.com/searchmedia=music&entity=song&term=abba")  // 1  
  let promise = expectation(description: "Completion handler invoked")  
  var statusCode: Int?  
  var responseError: Error?    
  // when  
  let dataTask = sessionUnderTest.dataTask(with: url!) { 
      data, response, error in statusCode = 
      (response as? HTTPURLResponse)?.statusCode    responseError = error    
                                                        
      // 2                                      
      promise.fulfill()  
  }  
  dataTask.resume()  
  // 3  
  waitForExpectations(timeout: 5, handler: nil)    
  // then  
  XCTAssertNil(responseError)  
  XCTAssertEqual(statusCode, 200)
  ```




#### Unit Test Flag

유닛테스트를 하려고 할 때 앱을 런치하는 과정에서 불필요한 작업을 수행할 때가 있다.
혹은 필요한 작업만 수행하려고 할 때 다음 플레그 설정법을 이용하면 된다.

1. 빌드 세팅에서 Test 탭의 Environment Variables 추가 (UNITTEST: 1)

2. 다음과 같이 앱 딜리게이트에 메서드 설정 후 사용하면 됨

   ```swift
   var isUnitTesting: Bool {
     return ProcessInfo.processInfo.environment["UNITTEST"] == "1"
   }
   
   // AppDelegate.swift
   func application(_ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions:
     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
     if !isUnitTesting {
       // Load Core Data
       // Setup dependencies
       // Other slow stuff..
     }
     return true
   }
   ```



#### Fake AppDelegate

기존 프로젝트에서 유닛테스트를 수행하려고하면 AppDelegate에서 시작하는 로직들이 많아 테스트 속도가 느려지는 경우가 있다. 혹은 테스트에 영향을 끼처 사이드이팩트가 발생할 수도 있다.
이를 방지하기 위해서 페이크 앱딜리게이트를 만들면 편하다.

1. Main.storyboard에서 시작하는 것을 코드로 변경한다.

2. 다음과 같은 방식으로 main.swift를 수정

3. ```swift
   let isRunningTests = NSClassFromString("XCTestCase") != nil
   //이건 앱딜리게이트 자체를 안타게 하는 방법
   //let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)	
   let appDelegateClass = isRunningTests ? NSStringFromClass(FakeAppDelegate.self) : NSStringFromClass(AppDelegate.self)
   let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
   UIApplicationMain(CommandLine.argc, args, nil, appDelegateClass)
   ```

4. 다음은 FakeAppDelegate 소스 (유닛테스트할 때에만 로그를 파일로 저장)

   ```swift
   import Foundation
    
   class FakeAppDelegate: NSObject {
    
       private let filename = "log_tests.txt"
    
       private var filepath: URL {
           guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
           return path.appendingPathComponent(filename)
       }
    
       private var logMessageData: Data {
           let timestamp = Date().timeIntervalSince1970
           let textMessage = "Test started at \(timestamp)"
           guard let data = "\(textMessage)\n".data(using: .utf8, allowLossyConversion: false) else { fatalError() }
           return data
       }
    
       override init() {
           super.init()
    
           writeTestLog()
       }
    
       private func writeTestLog() {
           if FileManager.default.fileExists(atPath: filepath.path) {
               appendLog()
           } else {
               writeFirstLog()
           }
       }
    
       private func appendLog() {
           if let fileHandle = FileHandle(forWritingAtPath: filepath.path) {
               fileHandle.seekToEndOfFile()
               fileHandle.write(logMessageData)
               fileHandle.closeFile()
           }
       }
    
       private func writeFirstLog() {
           do {
               try logMessageData.write(to: filepath, options: .atomicWrite)
           } catch { }
       }
   }
   ```

   

## UI TEST

음... 생각보다 불편해보여서 이걸 이용해서 효율을 높일 수 있을지 모르겠다...

좀 더 알아보는걸로...