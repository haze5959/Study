# iOS Swift Snippet

얼럿 다이얼로그(안에 텍스트필드도 있음!)

```swift
let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert); 
alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil));
alert.addTextField(configurationHandler: { 
    textField in textField.placeholder = "Input your name here..." 
});
alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in 
   if let name = alert.textFields?.first?.text { print("Your name: \(name)"); 
} }));
self.present(alert, animated: true)
```



### Alamofire + RXSwift Method

```swift
 func request(method: NetworkMethod, url: String, parameters: [String : Any]?) -> Observable<Any> {

	return Observable.create { observer in

		let method = method.httpMethod()
		let request = Alamofire.request(url, method: method, parameters: parameters)
					.validate()
					.responseJSON(queue: self.queue) { response in
						switch response.result {
							case .success(let value):
								observer.onNext(value)
								observer.onCompleted()

							case .failure(let error):
								observer.onError(NetworkError(error: error))
						}
					}
				
				return Disposables.create {
					request.cancel()
				}
			}
		}
```





### 좋은 사이트

https://github.com/soapyigu/Swift-30-Projects