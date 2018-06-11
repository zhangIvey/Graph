//
//  ClickAreaLayer.m
//  Graph
//
//  Created by yaoln on 2018/6/11.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "ClickAreaLayer.h"

@implementation ClickAreaLayer

- (instancetype)init
{
    self = [super init];
    if (self) {


        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(clickArea)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;


    }
    return self;
}

/**
 设置数据图的背景色渐变效果

 @param c1 开始的色值
 @param c2 渐变之后的色值
 */
- (CAGradientLayer *)backgroundColorChangeFrom:(UIColor *)c1 betweenColor:(UIColor *)c2 to:(UIColor *)c3
{
    CAGradientLayer *backgroundLayer = [CAGradientLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.colors = @[(__bridge id)c1.CGColor,
                               (__bridge id)c2.CGColor,
                               (__bridge id)c3.CGColor
                               ];
    backgroundLayer.startPoint = CGPointMake(0.5, 0);
    backgroundLayer.endPoint = CGPointMake(0.5, 1);
    backgroundLayer.type = kCAGradientLayerAxial;

    return backgroundLayer;
}


/**
 响应点击事件
 */
- (void)clickArea
{

}



-(void)drawInContext:(CGContextRef)ctx
{

     [self addSublayer:[self backgroundColorChangeFrom:[UIColor clearColor] betweenColor:[UIColor whiteColor] to:[UIColor clearColor]]];
}
@end
