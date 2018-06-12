//
//  GraphLayer.m
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "GraphLayer.h"

@implementation GraphLayer

/**
 初始化

 @return 对象实例
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _stepsPercent = @[@100,
                          @200,
                          @300,
                          @500,
                          @600,
                          @700,
                          @900,
                          @6000,
                          @120];

        rings = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 绘制响应的反馈区域

 @param areas 要绘制的区域集合
 */
- (void)addClickArea:(NSArray *)areas
{
    NSLog(@"areas = %@",areas);
    for (int i = 0; i < areas.count; i++) {
        float width = self.bounds.size.width/areas.count;
        CGRect rect = CGRectMake(i*width, 0, width, self.bounds.size.height);
        [self addSublayer:[self drawClickArea:rect]];
    }
}


/**
 绘制折线图

 @param ctx 绘制折线图的上下文
 @param point 折线图上的步数集合
 */
- (void)addLine:(CGContextRef)ctx points:(NSArray *)point
{
    float start_x = (self.bounds.size.width/point.count)/2;

    CGPoint addLines[point.count];
    for (int i = 0; i < point.count; i++) {
        NSNumber *stepCount = (NSNumber *)[point objectAtIndex:i];
        CGPoint point = CGPointMake(start_x + start_x * 2 * i, stepCount.floatValue/10000*100);
        addLines[i].x = point.x+20;
        addLines[i].y = point.y+20;
    }
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx , kCGLineCapRound);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextBeginPath(ctx);
    CGContextAddLines(ctx, addLines, point.count);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 3);
    CGContextStrokePath(ctx);
}


/**
 添加圆环

 @param pointYs 圆环的圆心集合
 */
- (void)addRings:(NSArray *)pointYs
{
    NSLog(@"point = %@",pointYs);

    float start_x = (self.bounds.size.width/pointYs.count)/2;
    for (int m = 0; m < pointYs.count; m++) {
        NSNumber *stepCount = (NSNumber *)[pointYs objectAtIndex:m];
        CGRect rect = CGRectMake(start_x + start_x * 2 * m, stepCount.floatValue/10000*100, 40, 40);
        [self addSublayer:[self drawRing:rect]];
    }
}

/**
 绘制点击反馈区域

 @param rect 区域空间
 @return 区域对象
 */
-(ClickAreaLayer *)drawClickArea:(CGRect )rect
{
    ClickAreaLayer *clickAreaLayer = [[ClickAreaLayer alloc] init];
    clickAreaLayer.frame = rect;
    [clickAreaLayer setNeedsDisplay];
    return clickAreaLayer;
}


/**
 绘制圆环

 @param rect 圆环的大小位置
 @return 圆环对象
 */
-(RingLayer *)drawRing:(CGRect)rect
{
    RingLayer *ringLayer = [[RingLayer alloc] init];
    ringLayer.frame = rect;
    [ringLayer setNeedsDisplay];
    if (rings != nil) {
        [rings removeAllObjects];
    }
    [rings addObject:ringLayer];
    return ringLayer;
}


#pragma mark - 自定义视图
-(void)drawInContext:(CGContextRef)ctx
{

    NSLog(@"_stepsPercent = %@",self.stepsPercent);
    [self addClickArea:self.stepsPercent];

    NSArray<NSNumber *> *stepsArray = [[NSArray alloc] initWithObjects:
                           [NSNumber numberWithFloat:10000],
                           [NSNumber numberWithFloat:1000],
                           [NSNumber numberWithFloat:9000],
                           [NSNumber numberWithFloat:3000],
                           [NSNumber numberWithFloat:5000],
                           [NSNumber numberWithFloat:10000],
                           [NSNumber numberWithFloat:14000],
                           [NSNumber numberWithFloat:18000],
                           [NSNumber numberWithFloat:9000],
                           nil];


    NSLog(@"stepsArray = %@",stepsArray);

    [self addRings:stepsArray];
    [self addLine:ctx points:stepsArray];
}

@end
