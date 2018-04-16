#import "ScrollPage.h"

@implementation ScrollPage
@synthesize scrollView, pageControl;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // for문을 이용해 이미지를 차례로 불러와 UIImageView에 세개의 이미지를 넣는다.
    // 그 세개의 이미지가 담긴 UIImageView를 UIScrollView에 addSubview메소드를 통해서 추가한다.
    
    int i=0;
    for (; i<3; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.png",i+1]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        imgView.frame = CGRectMake(scrollView.frame.size.width*i, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        
        [scrollView addSubview:imgView];
        [imgView release];
    }
    
    //scrollView 사이즈를 세개의 이미지가 담긴 UIImageView의 사이즈에 맞게 설정한다.
    // 즉 이미지 세개를 가로로 나열한 전체 크기라고 보면 된다.
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * i, scrollView.frame.size.height)];
    
    //ScrollView에 필요한 옵션을 적용한다.
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=YES;
    scrollView.alwaysBounceVertical=NO;
    scrollView.alwaysBounceHorizontal=NO;
    scrollView.pagingEnabled=YES;          //페이징 가능 여부 YES
    scrollView.delegate=self;
    
    //pageControl에 필요한 옵션을 적용한다.
    pageControl.currentPage =0;               //현재 페이지 index는 0
    pageControl.numberOfPages=3;          //페이지 갯수는 3개
    [pageControl addTarget:self action:@selector(pageChangeValue:) forControlEvents:UIControlEventValueChanged]; //페이지 컨트롤 값변경시 이벤트 처리 등록
    
    [self.view addSubview:pageControl];
}

//Login Button Action
-(IBAction) ActLogin:(id)sender {
    NSLog(@"Log-in Action");
}

//페이지 컨트롤 값이 변경될때, 스크롤뷰 위치 설정
- (void) pageChangeValue:(id)sender {
    UIPageControl *pControl = (UIPageControl *) sender;
    [scrollView setContentOffset:CGPointMake(pControl.currentPage*320, 0) animated:YES];
}

//스크롤이 변경될때 page의 currentPage 설정
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    pageControl.currentPage = floor((scrollView.contentOffset.x - pageWidth / 3) / pageWidth) + 1;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidAppear:(BOOL)animated
{
    [scrollView flashScrollIndicators]; // 스크롤바를 보였다가 사라지게 함
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.scrollView = nil;
    self.pageControl = nil;
}

- (void)dealloc {
    [scrollView release];
    [pageControl release];
    [super dealloc];
}


@end
