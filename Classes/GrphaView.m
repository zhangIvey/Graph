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

        //添加刻度
        graduationLayer = [[GraduationLayer alloc] init];
        graduationLayer.backgroundColor = [UIColor grayColor].CGColor;
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
    if (!baseLineLayer) {
        return;
    }
    CGPoint toPoint = CGPointMake(baseLineLayer.frame.size.width/2, 80);
    [baseLineLayer setPosition:toPoint];

    
    [CAAnimation ]
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






#pragma mark  绘制连接选段


#pragma mark  设置渐变色


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