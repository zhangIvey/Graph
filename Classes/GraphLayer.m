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
 添加圆环

 @param points 圆环的圆心集合
 */
- (void)addRings:(NSArray *)points
{
    NSLog(@"point = %@",points);
    for (int i = 0; i < points.count; i++) {
        float start_x = (self.bounds.size.width/points.count)/2;
        CGRect rect = CGRectMake(start_x + start_x * 2 * i, 19000, 40, 40);
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


    NSArray *stepsArray = [NSArray arrayWithObjects:
                           @12000,
                           @10000,
                           @2000,
                           @5000,
                           @16000,
                           @20000,
                           @8000,
                           @9000,
                           @14000, nil];

    NSLog(@"stepsArray = %@",stepsArray);
    for (int i = 0; i < stepsArray.count; i ++) {

        float x = []
        
        NSArray *points = [NSArray arrayWithObjects:@"", nil]
    }



    [self addRings:_stepsPercent];
}

@end
