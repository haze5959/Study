#import "Thread.h"

@implementation Thread

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//1개 thread만 생성하여 사용방법
_queue =[[NSOperationQueue alloc] init];
[_queue setMaxConcurrentOperationCount:1];

//큐 사용하기. 큐 없이 사용할거라면 이거 필요 없음
NSInvocationOperation* invo = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(threadFunction:) object:dic];
[_queue addOperation:invo];

//스레드 메서드
- (void) threadFunction :(id) object
{
    // 할 일
    
    // thread에 남아있는 작업 모두 캔슬
    [_queue cancelAllOperations];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // ui작업, 이미지 작업, 혹은 delegate함수 호출
    });
    
    
    //큐 없이 사용할거면 이것만 써서 가능
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        // 시간 많이 걸리는 코드
        dispatch_async(dispatch_get_main_queue(), ^{
            // ui작업, 이미지 작업
        });
        
    });
}



@end
