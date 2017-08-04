
#import "SGTip.h"
@interface SGTip()
@end
@implementation SGTip

+ (instancetype)loadTipWithContent:(NSString *)content InView:(UIView *) view
{

   SGTip *msgLabel = [[self alloc]init];

    //设置背景色
    msgLabel.backgroundColor = [UIColor darkGrayColor];
    msgLabel.text = content;
    //设置文字颜色
    msgLabel.textColor = [UIColor greenColor];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置label为圆角
    msgLabel.layer.cornerRadius = 8;
    msgLabel.layer.masksToBounds = YES;
    msgLabel.alpha = 0.0;
    [UIView animateWithDuration:1 animations:^{
        msgLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            msgLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
             [msgLabel removeFromSuperview];
        }];
    }];
    
    //设置label的frame
    CGFloat viewWidth = view.frame.size.width *0.5;
    CGFloat viewHeight = view.frame.size.height *0.5;
    msgLabel.center = CGPointMake(viewWidth, viewHeight);
    CGFloat msgLabelW = 150;
    CGFloat msgLabelH = 30;
    msgLabel.bounds = CGRectMake(0, 0, msgLabelW, msgLabelH);

    [view addSubview:msgLabel];
    
    return msgLabel;
}


@end
