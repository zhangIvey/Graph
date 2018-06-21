//
//  GraduationLayer.m
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "GraduationLayer.h"



@implementation GraduationLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _scalexX = [NSArray arrayWithObjects:@"2-1",@"2-2",@"2-3",@"2-4",@"2-5",@"2-6",@"2-7",@"2-8",@"2-9",@"2-10",@"2-11", nil];

        [self addObserver:self forKeyPath:@"self.scalexX" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"self.scalexX"]) {
        NSLog(@"重新设置坐标");
        NSLog(@"self.scalexX = %@",self.scalexX);
        [self setNeedsDisplay];
    }
}



/**
 绘制横坐标

 @param ctx 绘制刻度的上下文
 @param scales 横坐标上的刻度
 */
- (void)addXInContext:(CGContextRef)ctx Scales:(NSArray *)scales
{
    //添加刻度
    float scaleLabelWidth = -self.bounds.size.width/([scales count]-2);
    float scaleLabelHeith = 40;
    for (int i = 0; i < [scales count]; i ++) {
        CGRect rect = CGRectMake(scaleLabelWidth + fabsf(i*scaleLabelWidth), self.bounds.size.height - 40, scaleLabelWidth, scaleLabelHeith);
        [scaleXLabels addObject:[self scaleLabelInit:rect scale:(NSString *)[scales objectAtIndex:i]]];
        [self addSublayer:[self scaleLabelInit:rect scale:(NSString *)[scales objectAtIndex:i]]];
    }

}


/**
 生成刻度

 @param rect 刻度坐标
 @param scaleString 刻度
 @return 刻度实例
 */
- (CATextLayer *)scaleLabelInit:(CGRect)rect scale:(NSString *)scaleString
{
    CATextLayer *scaleLayer = [CATextLayer layer];
    scaleLayer.backgroundColor = [UIColor orangeColor].CGColor;
    scaleLayer.frame = rect;
    [scaleLayer setString:scaleString];
    scaleLayer.fontSize = 15;
    scaleLayer.alignmentMode = kCAAlignmentCenter;
    return scaleLayer;
}


/**
 纵轴
 */
- (void)addY
{

}




/**
 绘制X轴

 @param ctx 绘制X轴的上下文
 */
- (void)drawX:(CGContextRef) ctx{
    NSLog(@"开始绘制刻度视图");
    CGFloat lineHeight = self.bounds.size.height - 40;
    CGContextMoveToPoint(ctx, 0,lineHeight);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, lineHeight);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetLineWidth(ctx, 1);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);

}

#pragma mark - 自定义绘图
- (void)drawInContext:(CGContextRef)ctx
{
    //绘制X轴
    [self drawX:ctx];

    //添加X轴刻度
    [self addXInContext:ctx Scales:_scalexX];


}

@end
