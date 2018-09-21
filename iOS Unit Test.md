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

  

## UI Test

음... 생각보다 불편해보여서 이걸 이용해서 효율을 높일 수 있을지 모르겠다...

좀 더 알아보는걸로...