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

