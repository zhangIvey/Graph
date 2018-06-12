//
//  GrphaView.m
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "GrphaView.h"

@implementation GrphaView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

        //添加背景图层
        UIColor *color1 = [UIColor colorWithRed:1/225.0 green:160/255.0 blue:241/255.0 alpha:1];
        UIColor *color2 = [UIColor colorWithRed:138/255.0 green:209/255.0 blue:243/255.0 alpha:1];
        [self.layer addSublayer:[self backgroundColorChangeFrom:color1 to:color2]];


        //添加折线图图层
        graphLayer = [[GraphLayer alloc] init];
        graphLayer.frame = CGRectMake(0, 0, self.bounds.size.width, 300);
        graphLayer.backgroundColor = [UIColor clearColor].CGColor;
        [graphLayer setNeedsDisplay];
        [self.layer addSublayer:graphLayer];


        //添加刻度
        graduationLayer = [[GraduationLayer alloc] init];
        graduationLayer.backgroundColor = [UIColor clearColor].CGColor;
        graduationLayer.frame = CGRectMake(0, 0, self.bounds.size.width, 300);
        [graduationLayer setNeedsDisplay];
        [self.layer addSublayer:graduationLayer];


        //添加基准线
        baseLineLayer = [[BaseLineLayer alloc] init];
        baseLineLayer.backgroundColor = [UIColor clearColor].CGColor;
        baseLineLayer.frame = CGRectMake(0, 0,self.bounds.size.width, 20);
        baseLineLayer.position = CGPointMake(self.bounds.size.width/2, 200);
        [baseLineLayer setNeedsDisplay];
        [self.layer addSublayer:baseLineLayer];




        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBaseLine)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];


    }
    return self;
}

- (void)changeBaseLine
{

    //变更基准线
    CGPoint toPoint = CGPointMake(baseLineLayer.frame.size.width/2, 80);
    [self moveBaseLineToPoint:toPoint];

    //更换坐标刻度
    NSArray *scalesX = [NSArray arrayWithObjects:@"3-6",@"3-7",@"3-8",@"3-9",@"3-10",@"3-11",@"3-12",@"3-13",@"3-14", nil];
    [self graduationRefreshX:scalesX Y:nil];

    //重新绘制坐标原点和折线图
    NSArray<NSNumber *> *steps = [[NSArray alloc] initWithObjects:
                                  [NSNumber numberWithInteger:1000],
                                  [NSNumber numberWithInteger:1500],
                                  [NSNumber numberWithInteger:8000],
                                  [NSNumber numberWithInteger:16000],
                                  [NSNumber numberWithInteger:11000],
                                  [NSNumber numberWithInteger:200000],
                                  [NSNumber numberWithInteger:1000],
                                  [NSNumber numberWithInteger:900],
                                  [NSNumber numberWithInteger:3000],
                                  nil];

    [graphLayer setStepsPercent:steps];
}


/**
 变更基准线

 @param point 基准线将要移动到的坐标
 */
- (void)moveBaseLineToPoint:(CGPoint)point
{
    if (!baseLineLayer) {
        return;
    }
    [baseLineLayer setPosition:point];
}


/**
 变更坐标系

 @param scalesX 横轴坐标刻度集合
 @param scalesY 纵轴坐标刻度集合
 */
- (void)graduationRefreshX:(NSArray *)scalesX Y:(NSArray *)scalesY
{
    if (!graduationLayer) return;
    [graduationLayer setScalexX:scalesX];
}


/**
 设置数据图的背景色渐变效果

 @param c1 开始的色值
 @param c2 渐变之后的色值
 */
- (CAGradientLayer *)backgroundColorChangeFrom:(UIColor *)c1 to:(UIColor *)c2
{
    CAGradientLayer *backgroundLayer = [CAGradientLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.colors = @[(__bridge id)c1.CGColor,
                               (__bridge id)c2.CGColor];
    backgroundLayer.startPoint = CGPointMake(0.5, 0);
    backgroundLayer.endPoint = CGPointMake(0.5, 1);
    backgroundLayer.type = kCAGradientLayerAxial;

    return backgroundLayer;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    CALayer *layer = [self.layer hitTest:point];

    for (int i = 0; i < [graphLayer sublayers].count; i++) {
        CALayer *subLayer = (CALayer *)[[graphLayer sublayers] objectAtIndex:i];
        if (layer == subLayer) {
            subLayer.backgroundColor = [UIColor redColor].CGColor;
        }else{
            subLayer.backgroundColor = [UIColor clearColor].CGColor;
        }
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor redColor];
    self.layer.backgroundColor = [UIColor yellowColor].CGColor;
    
}
 */




@end
