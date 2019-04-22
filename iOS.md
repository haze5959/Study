# iOS

### Background task

```objective-c
UIBackgroundTaskIdentifier taskId;              

# pragma mark - background task

/**
 백그라운드 시작을 알리는 함수
*/

- (void)startBackgroundTask
  {
    // System 에 background 작업이 필요함을 알림. 작업의 id 반환
    taskId = [[UIApplication sharedApplication] 							beginBackgroundTaskWithExpirationHandler:^{
        	[[UIApplication sharedApplication] endBackgroundTask:taskId];
        	return ;
    		}];
  }
  /**
   백그라운드 끝을 알리는 함수
  */
- (void)endBackgroundTask
  {
    [[UIApplication sharedApplication] endBackgroundTask:taskId];
    taskId = 0;
  }
```

위와 같이 선언해 두고 다음과 같이 쓴다.

```objective-c
[self startBackgroundTask];
// 할일
[self endBackgroundTask];
```



### 타이머

```objective-c
[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStop) userInfo:nil repeats:NO];
/*
1.0 : 초를 나타낸다. 1초 후 실행
self : 자기가 가지고 있는 함수중에서 실행한다.
@selector(timerStop) : timerStop이라는 함수를 실행
nil : userInfo에 아무값도 전달하지 않음
NO : 반복하지 않음
*/
-(void) timerStop
{
   // 할 일
}
```

더 심플한거

```objective-c
[self performSelector:@selector(function) withObject:nil afterDelay:1.0];
//위와 같이 사용하면 function이란 함수를 1초 뒤에 실행
```



### Formatter

```objective-c
NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
NSNumber *num = @1234567890.1234;
NSLog(@"Result : %@", [numberFormatter stringFromNumber:num]);
//Result : Result : 1,234,567,890.1234

NSNumberFormatterNoStyle는 소수점 이하를 버립니다.
NSNumberFormatterPercentStyle는 소수점 3자리 이하를 버리고 소수점이 없어지며 끝에 %가 붙습니다.
NSNumberFormatterCurrencyStyle는 소수점 이하를 버리고 통화량 기호가 앞에 붙습니다.
NSNumberFormatterSpellOutStyle는 언어에 맞는 문자로 표현
//Result : 십이억 삼천사백오십육만 칠천팔백구십점일이삼사오
```



### view 관련

```objective-c
//뷰 특정 위치에 삽입
[self.view insertSubview:viewController.view atIndex:0];
//서브뷰
[self.view addSubview:viewController.view]; 
//해당 컨트롤러의 뷰를 보여준다
[self presentViewController:controller animated:YES completion:nil];
//네비게이션
[self.navigationController pushViewController:addView animated:YES];

//뷰의 순서 바꾸기
[self.view bringSubviewToFront:self.tempViewController.view]; 
-> tempViewController.view를 가장 앞으로 이동한다. 

[self.view sendSubviewToFront:self.tempViewController.view]; 
-> tempViewController.view를 가장 뒤로 이동한다. 

[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:2]; 
-> 0번 뷰와 2번뷰의 위치를 바꾼다 
   위에서 insertSubView .... atIndex로 뷰의 번호를 지정하면 view가 쌓인다 
   이 순서를 변경할수 있다. 
   주위 해야 할것은 Atindex:number로 뷰를 넣을 경우 해당 뷰가 number로 계속
   지정 되는 것이 아니라 이동후에는 각각의 위치 번호로 된다. 

//제일 앞에다 뷰를 보여준다
[self.window makeKeyAndVisible];

//뷰 스택 로그 찍기 
NSLog([[self.view subviews] description]); 
-> 뷰가 쌓여 있는 스택(?) 순서를 콘솔로 볼수 있다. 
   로그를 볼때는 view에 tag로 번호를 지정한다음에 보면 콘솔에 해당 tag가 나와서 
   한결 보기 편하다. 
```

현재의 흐름을 잠시 중단하고 원래의 흐름으로 다시 되돌아 오도록 애플리케이션의 흐름을 구현하고자 할 때 
모달 뷰를 사용
모달 뷰 모델에서는 호출자(Caller)와 피호출자(Callee)간의 부모(Parent)와 자식(Child) 관계가 생깁니다.

```objective-c
// 새로운 뷰 컨트롤러를 모달로 표시
[self presentModalViewController:viewController animated:YES];  
// 현재 모달로 띄워진 뷰 컨트롤러를 닫음
[self dismissModalViewControllerAnimated:YES];  
//전환 효과
[viewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
// UIModalTransitionStyleCoverVertical : 모달 뷰가 아래서 위로 덮으며 전환됩니다. (기본값)
// UIModalTransitionStyleFlipHorizontal : 앞면의 부모 뷰가 회전되어 뒷면의 모달 뷰로 전환됩니다
// UIModalTransitionStyleCrossDissolve : 부모 뷰가 서서히 사라짐과 동시에 모달 뷰로 전환됩니다.
// UIModalTransitionStylePartialCurl : 부모 뷰가 종이처럼 휘어지며 모달 뷰로 전환됩니다. 
```



### 제스쳐

```objective-c
UITapGestureRecognizer 터치 - 손으로 터치
UIPinchGestureRecognizer 핀치 - 두 손가락 으로 확대 축소
UIRotationGestureRecognizer 로테이션 - 손으로 회전
UISwipeGestureRecognizer 스왑 - 눌러서 밀기 
UIPanGestureRecognizer 펜 - 드레그
UILongPressGestureRecognizer 롱프레스 - 오래 눌렀을 경우

//제스처 생성
UITapGestureRecognizer* clickBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//제스처 등록
[registrationFirstView addGestureRecognizer:clickBg];
//몇번 탭하는지
tripleTap.numberOfTapsRequired = 3;
//몇 손가락으로 탭하는지
[tripleTap setNumberOfTouchesRequired:3];
```



### CGContext

```objective-c
//선 그리기 위한 준비
UIGraphicsBeginImageContext(self.view.frame.size);
[self.drawImage.image drawInRect:CGRectMake(0, 0, self.drawImage.frame.size.width, self.drawImage.frame.size.height)];

//선 생성
CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
CGContextBeginPath(UIGraphicsGetCurrentContext());
CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 60, (waterPerTen * (9 - i) + 20));
CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.view.frame.size.width - 10, (waterPerTen * (9 - i) + 20));
CGContextStrokePath(UIGraphicsGetCurrentContext());

//선 적용하고 그리기 끝
self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

//원그리기
[self.circleView drawCircleWithPercent:percent
                 duration:1
                 lineWidth:11
                 clockwise:YES
                 lineCap:kCALineCapButt
                 fillColor:[UIColor clearColor]
                 strokeColor:UIColorFromRGB(rgbCode)
                 animatedColors:nil];
    [self.circleView startAnimation];
```



### 생명주기

```objective-c
   - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
     => 어플리케이션이 처음 실행될 때. (처음 메모리상에 올라가게 될 때를 말함) 
   - (void)applicationDidBecomeActive:(UIApplication *)application
     => 어플리케이션이 활성화 될 때, 
       즉 didFinishLaunchingWithOption 호출 직후, 어플리케이션이 백그라운드로 돌아갔다가 다시 불러질 때 호출
   - (void)applicationWillResignActive:(UIApplication *)application
     => 어플리케이션이 백그라운드로 들어가기 직전(홈버튼을 누른 직후)에 호출 됨
   - (void)applicationDidEnterBackground:(UIApplication *)application
     => 어플리케이션이 백그라운드로 완전히 들어갔을 때 호출됨
   - (void)applicationWillEnterForeground:(UIApplication *)application
     => 어플리케이션이 다시 활성되 되기 직전에 호출됨
      (백그라운드 상에서 다시 어플리케이션이 활성되 되면 willEnterForeground 호출 후 applicationDidBecomeActive 호출)
   - (void)applicationWillTerminate:(UIApplication *)application 
     => 어플리케이션이 완전히 종료되기 직전에 호출 됨

   =============================뷰 컨트롤러======================================

   - (void)loadView
     뷰 컨트롤러에 보여지는 컨트롤러들을 생성하거나 추가할 때 적당한 부분 
   - (void)viewWillAppear:(BOOL)animated
     뷰 컨트롤러가 사용자에게 보여지기 직전에 호출(복수 호출 가능) 
     loadView 다음에 호출 됨 
   - (void)viewDidLoad
     viewWillAppear 다음에 호출 됨 (단 한번만 호출됨) 
   - (void)viewDidAppear:(BOOL)animated
     viewDidLoad 다음에 호출 됨(복수 호출 가능)
   - (void)viewWillDisappear:(BOOL)animated
     해당 뷰컨트롤러가 사라지기 직전에 호출됨  
   - (void)viewDidUnload
     viewWillDisappear 이후에 호출됨
   - (void)viewDidDisappear:(BOOL)animated
     viewDidUnload 이후에 호출됨
```

   ​

### 각종 정보

```objective-c
//시스템 OS 이름
[[UIDevice currentDevice] systemName];

//시스템 버전
[[UIDevice currentDevice] systemVersion];

//기기 이름
[[UIDevice currentDevice] name];

//폰 패드 구분
UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

//기기 방향성
[[UIDevice currentDevice] orientation];

//배터리 잔여량
[[UIDevice currentDevice] batteryLevel];

//배터리 상태
[[UIDevice currentDevice] batteryState];

//어플 이름
[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];

//어플 버전
[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
```



## 스크롤뷰

##### 컨텐츠 관리

```objective-c
// Content Offset
[scrollView setContentOffset:CGPointMake(100.0f, 100.0f)];
CGPoint offset = [scrollView contentOffset];

// Content Size
CGSize size = [scrollView contentSize];
scrollView.contentSize = CGSizeMake(320, 480);

// Content 상하에 여백을 추가한다.
scrollView.contentInset = UIEdgeInsetsMake(64.0,0.0,44.0,0.0);

// 스크롤 바 스타일
scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;

// 스크롤 바 표시
scrollView.showsHorizontalScrollIndicator = YES;
scrollView.showsVerticalScrollIndicator = YES;

// 특정 시점에 스크롤바 표시
[scrollView flashScrollIndicators];

// 스크롤 바 위치 설정
scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
```

#### 스크롤 설정

```objective-c
// 스크롤 설정
scrollView.scrollEnabled = YES;

// 수직/수평 한 방향으로만 스크롤 되도록 설정
scrollView.directionalLockEnabled = YES;

// 상태바를 클릭할 경우 가장 위쪽으로 스크롤 되도록 설정. scrollViewDidScrollToTop: 델리게이트 메소드로 적절한 처리를 해 주어야 한다.
scrollView.scrollsToTop = YES;

// 특정 사각 영역이 뷰에 표시되도록 오프셋 이동
[scrollView scrollRectToVisible:CGRectMake(50.0, 50.0, 100.0, 100.0)

// 페이징 설정
scrollView.pagingEnabled = NO;

// 스크롤이 경계를 넘어섰다가 다시 복귀했는지 판별
if (scrollView.bounces) {
    NSLog(@"Bounce");
}

// 스크롤이 경계에 도달하면 바운싱효과를 적용
scrollView.alwaysBounceHorizontal = YES;
scrollView.alwaysBounceVertical = YES;

// 스크롤뷰를 터치할 경우 컨텐츠 내부의 뷰에 이벤트 전달
[scrollView touchesShouldBegin:touches withEvent:evt inContentView:contentInView];
[scrollView touchesShouldCancelInContentView:contentInView];

// 터치이벤트가 발생할 경우 딜레이를 두고 touchesShouldBegin:withEvent:inContentView: 메소드를 호출
scrollView.delaysContentTouches = YES;

// 감속 속도 조절
scrollView.decelerationRate = UIScrollViewDecelerationRateFast;

// 스크롤을 하기 위해 뷰를 터치했는지 판별
if (scrollView.tracking) {
NSLog(@"User has touched the content view but might not have yet have started dragging it");
}

// 스크롤이 시작되었는지 판별
if (scrollView.dragging) {
    NSLog(@"Dragging or Scrolling....");
}

// 스크롤이 종료되고 감속중인지 판별
if (scrollView.decelerating) {
    NSLog(@"User isn't dragging the content but scrolling is still occurring");
}
```



## Dispatch

#### 디스패치 큐 생성

```objective-c
// 새로운 시리얼 디스패치 큐를 생성한다(2번째 인자에 NULL 넣으면 디폴트로 시리얼 디스패치 생성)
dispatch_queue_t serialQueue = dispatch_queue_create("com.davin.serialqueue", DISPATCH_QUEUE_SERIAL);
    
// 새로운 콘커런트 디스패치 큐를 생성한다(넣은 스레드들이 한번에 같이 실행(sync로 실행하면 순차적으로 나옴))
dispatch_queue_t concurrentQueue = dispatch_queue_create("com.davin.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
// 메인 디스패치 큐를 얻어온다
dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
// 글로벌 디스패치 큐를 얻어온다
dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
```

### 사용법

```objective-c
// 비동기로 작업을 추가 및 수행한다
void dispatch_async(dispatch_queue_t queue, dispatch_block_t block);
// 동기로 작업을 추가 및 수행한다
void dispatch_sync(dispatch_queue_t queue, dispatch_block_t block);

//예
dispatch_queue_t queue = dispatch_queue_create("com.davin.queue", NULL);
dispatch_async(queue, ^{ NSLog(@"Call 1"); });
dispatch_async(queue, ^{ NSLog(@"Call 2"); });
dispatch_async(queue, ^{ NSLog(@"Call 3"); });
dispatch_async(queue, ^{ NSLog(@"Call 4"); });
dispatch_async(queue, ^{ NSLog(@"Call 5"); });
```

### 2초후에 작업을 수행하자

```objective-c
dispatch_queue_t queue = dispatch_queue_create("com.davin.queue", DISPATCH_QUEUE_SERIAL);

double delayInSeconds = 2.0;
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
dispatch_after(popTime, queue, ^{  NSLog(@"Call 1"); });
dispatch_async(queue, ^{ NSLog(@"Call 2"); });

# //결과는 Call 2가 바로 실행되고 2초후 Call 1이 실행
```

###  스레드 그룹이 작업이 끝났을 경우 알림을 받자
```objective-c
dispatch_group_t group = dispatch_group_create();
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

dispatch_group_async(group, queue, ^{ NSLog(@"Call 1"); });
dispatch_group_async(group, queue, ^{ NSLog(@"Call 2"); });
dispatch_group_async(group, queue, ^{ NSLog(@"Call 3"); });

dispatch_group_notify(group, queue, ^{ NSLog(@"Finished!"); });
```



## NSLog

%@ = 모든 코코아 오브젝트
%d = int
%f = float
%s = char

사용예)
NSLog(@"pi = %.3f", 3.145454);

//다음 메크로를 %s 토큰과 함께 사용하면 로그를 찍을 때 편하다.
__FUNCTION__	:	현재 실행 중인 메소드 이름
__LINE__	:	실행 중인 줄 번호
__FILE__	:	실행 중인 파일 이름