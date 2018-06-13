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
        _stepsPercent = [[NSArray alloc] initWithObjects:
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

        rings = [[NSMutableArray alloc] init];
        clickLayers = [[NSMutableArray alloc] init];

//        graphColor = [[CAGradientLayer alloc] init];

        [self addObserver:self forKeyPath:@"self.stepsPercent" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"self.stepsPercent"]) {

        [self setNeedsDisplay];
    }
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
        if (clickLayers.count >= i+1) {

        }else{
            ClickAreaLayer *areaLayer = [self drawClickArea:rect];
            [clickLayers addObject:areaLayer];
            [self addSublayer:areaLayer];
        }
    }
}


/**
 绘制折线图

 @param ctx 绘制折线图的上下文
 @param point 折线图上的步数集合
 */
- (void)addLine:(CGContextRef)ctx points:(NSArray *)point
{

    //绘制曲线
    float start_x = (self.bounds.size.width/point.count)/2;

    CGPoint addLines[point.count];
    for (int i = 0; i < point.count; i++) {
        NSNumber *stepCount = (NSNumber *)[point objectAtIndex:i];
        CGPoint point = CGPointMake(start_x + start_x * 2 * i, stepCount.floatValue/10000 * 100);
        addLines[i].x = point.x;
        addLines[i].y = point.y;
    }
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx , kCGLineCapRound);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextBeginPath(ctx);
    CGContextAddLines(ctx, addLines, point.count);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);

    if (graphColor == nil) {
        graphColor = [self drawChangeColor:addLines steps:point];
         [self addSublayer:graphColor];
    }else{
        //更新遮罩图层
        graphColor.mask = [self maskShapeLayer:addLines step:point];
    }

}

- (CAShapeLayer *)maskShapeLayer:(CGPoint[]) addLines step:(NSArray *)points
{
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = [self changePath:addLines step:points].CGPath;
    return arc;
}

- (UIBezierPath *)changePath:(CGPoint[]) addLines step:(NSArray *)points
{
    float start_x = (self.bounds.size.width/points.count)/2;
    UIBezierPath *gradientPath = [UIBezierPath bezierPath];
    [gradientPath moveToPoint:CGPointMake(addLines[0].x, self.frame.size.height)];
    for (int i = 0; i < points.count; i++) {
        NSNumber *stepCount = (NSNumber *)[points objectAtIndex:i];
        CGPoint point = CGPointMake(start_x + start_x * 2 * i, stepCount.floatValue/10000 * 100);
        addLines[i].x = point.x;
        addLines[i].y = point.y;
        [gradientPath addLineToPoint:point];
    }
    [gradientPath addLineToPoint:CGPointMake(addLines[points.count-1].x, self.frame.size.height)];
    return gradientPath;
}

- (CAGradientLayer *)drawChangeColor:(CGPoint[]) addLines steps:(NSArray *)points
{
    //绘制曲线下的渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.frame;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:170/255.0 blue:10/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.4].CGColor];

    gradientLayer.locations=@[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(1,0);

//    float start_x = (self.bounds.size.width/points.count)/2;
//    UIBezierPath *gradientPath = [UIBezierPath bezierPath];
//    [gradientPath moveToPoint:CGPointMake(addLines[0].x, self.frame.size.height)];
//    for (int i = 0; i < points.count; i++) {
//        NSNumber *stepCount = (NSNumber *)[points objectAtIndex:i];
//        CGPoint point = CGPointMake(start_x + start_x * 2 * i, stepCount.floatValue/10000 * 100);
//        addLines[i].x = point.x;
//        addLines[i].y = point.y;
//        [gradientPath addLineToPoint:point];
//    }
//    [gradientPath addLineToPoint:CGPointMake(addLines[points.count-1].x, self.frame.size.height)];


    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = [self changePath:addLines step:points].CGPath;

    gradientLayer.mask = arc;
    return gradientLayer;
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
        if (rings.count >= m+1) {
            RingLayer *ringLayer = (RingLayer *)[rings objectAtIndex:m];
            ringLayer.frame = rect;
            ringLayer.position = CGPointMake(rect.origin.x, rect.origin.y);
        }else{
            RingLayer *circleLayer = [self drawRing:rect];
            [rings addObject:circleLayer];
            [self addSublayer:circleLayer];
        }

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
    ringLayer.position = CGPointMake(ringLayer.frame.origin.x, ringLayer.frame.origin.y);
    [ringLayer setNeedsDisplay];
    return ringLayer;

/*
    //创建背景圆环
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    //清空填充色
    trackLayer.fillColor = [UIColor whiteColor].CGColor;
    //设置画笔颜色 即圆环背景色
    trackLayer.strokeColor = [UIColor orangeColor].CGColor;
    trackLayer.lineWidth = 2;
    //设置画笔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.origin.x, rect.origin.y) radius:rect.size.width/2.0 - 10 startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
    //path 决定layer将被渲染成何种形状
    trackLayer.path = path.CGPath;
*/

}


#pragma mark - 自定义视图
-(void)drawInContext:(CGContextRef)ctx
{

    NSLog(@"_stepsPercent = %@",self.stepsPercent);

    [self addLine:ctx points:self.stepsPercent];
    [self addClickArea:self.stepsPercent];
    [self addRings:self.stepsPercent];
}

@end
