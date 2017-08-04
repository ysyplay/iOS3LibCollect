/********************* 有任何问题欢迎反馈给我 liuweiself@126.com ****************************************/
/***************  https://github.com/waynezxcv/Gallop 持续更新 ***************************/
/******************** 正在不断完善中，谢谢~  Enjoy ******************************************************/





#import "CornerRadiusViewController.h"
#import "Gallop.h"

@interface CornerRadiusViewController ()


@end

@implementation CornerRadiusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LWImageStorage示例";
    self.view.backgroundColor = [UIColor whiteColor];
    
    LWAsyncDisplayView* view = [[LWAsyncDisplayView alloc]
                                initWithFrame:CGRectMake(0.0f, 64.0f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f)];
    [self.view addSubview:view];
    
    LWTextStorage* ts = [[LWTextStorage alloc] initWithFrame:CGRectMake(20.0f, 20.0f, SCREEN_WIDTH - 40.0f, CGFLOAT_MAX)];
    ts.text = @"使用Gallop可以直接给网络图片设置圆角半径、描边处理、模糊效果，下载完成后将对处理过的图片额外缓存一份，而不需要每次都重复处理。";
    ts.font = [UIFont fontWithName:@"Heiti SC" size:16.0f];
    ts.textAlignment = NSTextAlignmentCenter;
    
    //1.普通的加载网络图片
    LWImageStorage* is1 = [[LWImageStorage alloc] init];
    is1.contentMode = UIViewContentModeScaleAspectFill;
    is1.frame = CGRectMake(SCREEN_WIDTH/2 - 50.0f, ts.bottom + 10.0f, 100.0f, 100.0f);
    is1.contents = [NSURL URLWithString:@"http://img4.bitautoimg.com/autoalbum/files/20101220/862/13374086240035_1469891_15.JPG"];
    is1.clipsToBounds = YES;
    
    
    //2.本地图片
    LWImageStorage* lis = [[LWImageStorage alloc] init];
    lis.contents = [UIImage imageNamed:@"test"];
    lis.backgroundColor = [UIColor grayColor];
    lis.cornerRadius = 25.0f;
    lis.cornerBackgroundColor = [UIColor whiteColor];
    lis.cornerBorderColor = [UIColor redColor];
    lis.cornerBorderWidth = 3.0f;
    lis.contentMode = UIViewContentModeScaleAspectFill;
    lis.frame = CGRectMake(SCREEN_WIDTH/2 - 50.0f, is1.bottom + 10.0f, 100.0f, 100.0f);
    
    
    //3.网络图片设置圆角半径和模糊效果
    LWImageStorage* is2 = [[LWImageStorage alloc] init];
    is2.frame = CGRectMake(SCREEN_WIDTH/2 - 50.0f, lis.bottom + 10.0f, 100.0f, 100.0f);
    is2.contents = [NSURL URLWithString:@"http://img4.bitautoimg.com/autoalbum/files/20101220/862/13374086240035_1469891_15.JPG"];
    is2.cornerRadius = 50.0f;
    is2.contentMode = UIViewContentModeScaleAspectFill;
    is2.isBlur = YES;
    
    
    //4.直接对CALayer对象使用
    UIView* view2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50,
                                                                  64.0f + is2.bottom + 10 ,
                                                                  100.0f,
                                                                  100.0f)];
    [self.view addSubview:view2];
    [view2.layer lw_setImageWithURL:
     [NSURL URLWithString:@"http://img4.bitautoimg.com/autoalbum/files/20101220/862/13374086240035_1469891_15.JPG"]
                   placeholderImage:nil
                       cornerRadius:50.0f
              cornerBackgroundColor:RGB(255, 255, 255, 1.0f)
                        borderColor:[UIColor orangeColor]
                        borderWidth:5.0f
                               size:CGSizeMake(100.0f, 100.0f)
                        contentMode:UIViewContentModeScaleAspectFill
                             isBlur:NO
                            options:0
                           progress:nil
                          completed:nil];
    
    
    LWLayout* layout = [[LWLayout alloc] init];
    [layout addStorages:@[ts,is1,lis,is2]];
    view.layout = layout;
}


@end
