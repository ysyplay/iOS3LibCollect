
#import <UIKit/UIKit.h>

@interface SGTip : UILabel
//在某个视图中弹出提示框
+ (instancetype)loadTipWithContent:(NSString *)content InView:(UIView *) view;

@end
