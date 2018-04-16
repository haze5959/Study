#import "ImagePicker.h"

@implementation ImagePicker

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 갤러리 띄우기
UIImagePickerController* picker = [[UIImagePickerController alloc] init];
picker.delegate = self;
picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

[self presentViewController:picker animated:NO completion:nil];

// 델리게이트 함수
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //여기서 지지고 볶고
}

@end
