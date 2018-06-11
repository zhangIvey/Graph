//
//  RingLayer.m
//  Graph
//
//  Created by yaoln on 2018/6/11.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "RingLayer.h"

@implementation RingLayer

-(void)drawOuterCircle:(CGPoint)point redia:(float)r
{
    //创建背景圆环
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    //清空填充色
    trackLayer.fillColor = [UIColor whiteColor].CGColor;
    //设置画笔颜色 即圆环背景色
//    trackLayer.strokeColor =  [UIColor colorWithRed:170/255.0 green:210/255.0 blue:254/255.0 alpha:1].CGColor;
    trackLayer.strokeColor = [UIColor orangeColor].CGColor;
    trackLayer.lineWidth = 2;
    //设置画笔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:r startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
    //path 决定layer将被渲染成何种形状
    trackLayer.path = path.CGPath;
    [self addSublayer:trackLayer];

}

#pragma mark 自定义视图
-(void)drawInContext:(CGContextRef)ctx
{
    NSLog(@"绘制圆环");
    [self drawOuterCircle:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) redia:self.frame.size.width/2.0 - 10];
}

@end
