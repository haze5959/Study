#import <UIKit/UIKit.h>
@interface ScrollPage : UIViewController <UIScrollViewDelegate> { //UIScrollViewDelegate를 추가
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

@property(nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic, retain) IBOutlet UIPageControl *pageControl;

@end
