//
//  LHRatingView.m
//  TestStoryboard
//
//  Created by bosheng on 15/11/4.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import "LHRatingView.h"


#define starNumber 5.0f

@interface LHRatingView()
{
    CGFloat eachWidth;
}

@property (nonatomic,assign)CGFloat widDistance;//星星之间的左右间隔
@property (nonatomic,assign)CGFloat heiDistance;//星星之间的上下间隔

@property (nonatomic,strong)UIView * grayStarView;//灰色星星
@property (nonatomic,strong)UIView * foreStarView;//表示分数星星

@property (nonatomic,assign)CGFloat lowestScore;//最低分数
@property (nonatomic,assign)CGFloat maxScore;//最高分数

@end

@implementation LHRatingView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.ratingType = FLOAT_TYPE;
        self.widDistance = 5.0f;
        self.heiDistance = 5.0f;
        self.lowestScore = 1.0f;
        
        self.grayStarView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.grayStarView];
        self.foreStarView = [[UIView alloc]initWithFrame:self.bounds];
        self.foreStarView.clipsToBounds = YES;
        [self addSubview:self.foreStarView];
        
        eachWidth = (CGRectGetWidth(self.frame)-(starNumber-1)*self.widDistance)/starNumber;
        CGFloat height = CGRectGetHeight(self.frame)-2*self.heiDistance;
        for (int i = 0; i < starNumber; i++) {
            UIImage * grayImg = [UIImage imageNamed:@"starGray"];
            UIImageView * grayImgView = [[UIImageView alloc]initWithFrame:CGRectMake((eachWidth+self.widDistance)*i, self.heiDistance, eachWidth, height)];
            grayImgView.image = grayImg;
            [self.grayStarView addSubview:grayImgView];
            
            UIImage * foreImg = [UIImage imageNamed:@"starFore"];
            UIImageView * foreImgView = [[UIImageView alloc]initWithFrame:CGRectMake((eachWidth+self.widDistance)*i, self.heiDistance, eachWidth, height)];
            foreImgView.image = foreImg;
            [self.foreStarView addSubview:foreImgView];
        }

        
        self.score = 1.5;
    }
    
    return self;
}
#pragma mark - 设置是否可以交互
-(void)setEnable:(BOOL)enable
{
    _enable = enable;
    if (_enable)
    {
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureEvent:)];
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureEvent:)];
        
        [self addGestureRecognizer:tapGesture];
        [self addGestureRecognizer:panGesture];
    }
   
}

#pragma mark - 设置当前分数
- (void)setScore:(CGFloat)score
{
    _score = score;
    
    if (_ratingType == INTEGER_TYPE) {
        _score = (int)score;
    }

    CGPoint p = CGPointMake((eachWidth+self.widDistance)*_score, self.heiDistance);
    [self changeStarForeViewWithPoint:p];
}

#pragma mark - 设置当前类型
- (void)setRatingType:(RatingType)ratingType
{
    _ratingType = ratingType;
    if (_ratingType == FLOAT_TYPE)
    {
        _maxScore = 5;
    }
    else
    {
        _maxScore = 10;
    }
    [self setScore:_score];
}

#pragma mark - 点击
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap_
{
    CGPoint point = [tap_ locationInView:self];
    
    if(_ratingType == INTEGER_TYPE){
        NSInteger count = (NSInteger)(point.x/(eachWidth+self.widDistance)*2)+1;
        point.x = count*(eachWidth+self.widDistance)/2;
    }
    
    [self changeStarForeViewWithPoint:point];
}
#pragma mark - 滑动
- (void)panGestureEvent:(UIPanGestureRecognizer *)pan_
{
    
    CGPoint point = [pan_ locationInView:self];

    if (point.x < 0) {
        return;
    }
    if(_ratingType == INTEGER_TYPE){
        NSInteger count = (NSInteger)(point.x/(eachWidth+self.widDistance)*2)+1;
        point.x = count*(eachWidth+self.widDistance)/2;
    }
    
    [self changeStarForeViewWithPoint:point];
}

#pragma mark - 设置显示的星星
- (void)changeStarForeViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    NSLog(@"-%f--- %f",self.lowestScore,p.x);
    
    if (p.x < 0) {
        return;
    }
    
    if (p.x < self.lowestScore)
    {
        p.x = self.lowestScore;
    }
    else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
//    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float sc = p.x/CGRectGetWidth(self.frame);
//    p.x = sc * self.frame.size.width;
    NSLog(@"sc  %f",sc);
    
    CGRect fRect = self.foreStarView.frame;
    fRect.size.width = p.x;
    self.foreStarView.frame = fRect;
    
    _score = sc*_maxScore;
    
    if(_ratingType == INTEGER_TYPE){
        NSLog(@"a");
        _score = ((int)_score)/2.0;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(ratingView:score:)])
    {
        [self.delegate ratingView:self score:self.score];
    }
}


@end
