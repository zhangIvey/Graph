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

        [self addObserver:self forKeyPath:@"self.selectedColor" options:NSKeyValueObservingOptionNew context:nil];

        _selectedColor = [UIColor clearColor];
        backgroundLayer = [CAGradientLayer layer];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"self.selectedColor"]) {
        [self setNeedsDisplay];
    }
}

-(CALayer *)hitTest:(CGPoint)p
{
    NSLog(@"便跟颜色");
    self.selectedColor = [UIColor whiteColor];
    return self;
}

/**
 设置数据图的背景色渐变效果

 @param c1 开始的色值
 @param c2 渐变之后的色值
 */
- (CAGradientLayer *)backgroundColorChangeFrom:(UIColor *)c1 betweenColor:(UIColor *)c2 to:(UIColor *)c3
{

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
 高亮一下
 */
- (void)shine
{

}


-(void)drawInContext:(CGContextRef)ctx
{

    CAGradientLayer *backgroudColorLayer = [self backgroundColorChangeFrom:[UIColor clearColor] betweenColor:self.selectedColor to:[UIColor clearColor]];
    [self addSublayer:backgroudColorLayer];
    
}
@end
