# MacOS

#### StatusBar 아이콘 추가하기

```swift
self.statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
if let button = self.statusItem.button {
	button.image = NSImage(named:NSImage.Name("StatusBar"))
	button.action = #selector(printQuote(_:))
}

// MARK: StatusBar Btn Evnet
    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        print("\(quoteText) — \(quoteAuthor)")
    }
```



#### Dock에 아이콘 안보이고 데몬으로 돌리기(Plist)

```
Application is agent (UIElement) - YES
```



#### Dock 아이콘 유무를 runtime에 결정하기

```swift
//dismiss in dock
var psn = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: UInt32(kCurrentProcess))        
TransformProcessType(&psn, ProcessApplicationTransformState(kProcessTransformToUIElementApplication) )

//showing in dock
var psn = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: UInt32(kCurrentProcess))        
TransformProcessType(&psn, ProcessApplicationTransformState(kProcessTransformToForegroundApplication) )
```



#### PopOver View 넣기

```swift
if let button = self.statusItem.button {
	button.image = NSImage(named:NSImage.Name("StatusBar"))
	button.action = #selector(togglePopover(_:))
}

self.popover.contentViewController = PopOverViewController()

@objc func togglePopover(_ sender: Any?) {
	if popover.isShown {
		closePopover(sender: sender)
	} else {
		showPopover(sender: sender)
	}
}  

func showPopover(sender: Any?) {
	if let button = statusItem.button {
		self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
	}
}

func closePopover(sender: Any?) {
	self.popover.performClose(sender)
}
```

