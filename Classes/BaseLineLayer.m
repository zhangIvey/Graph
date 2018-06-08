//
//  BaseLineLayer.m
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "BaseLineLayer.h"

@implementation BaseLineLayer

/**
 绘制基准线

 @param ctx 图层上下文
 */
-(void)drawBaseLineInContext:(CGContextRef)ctx
{
    CGFloat lineHeight = self.bounds.size.height - 1;
    CGContextMoveToPoint(ctx, 0,lineHeight);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, lineHeight);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetLineWidth(ctx, 1);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}


/**
 绘制基准线备注

 @param infoString 备注信息
 @return 备注对象
 */
- (CATextLayer *)annotationInfo:(NSString *)infoString
{
    CATextLayer *annotationLayer = [CATextLayer layer];
    annotationLayer.frame = CGRectMake(0, 0, 40, 20);
    annotationLayer.string = @"1W";
    annotationLayer.backgroundColor = [UIColor clearColor].CGColor;
    annotationLayer.fontSize = 18;
    annotationLayer.alignmentMode = kCAAlignmentLeft;
    annotationLayer.foregroundColor = [UIColor redColor].CGColor;
    return annotationLayer;
    
}


#pragma mark - 自定义图层
-(void)drawInContext:(CGContextRef)ctx
{
    [self drawBaseLineInContext:ctx];
    [self addSublayer:[self annotationInfo:@"1W"]];
}

@end
