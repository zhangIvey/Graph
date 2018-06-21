//
//  VernierLayer.m
//  Graph
//
//  Created by yaoln on 2018/6/19.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "VernierLayer.h"

@implementation VernierLayer

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx
{
    // 绘图
    CGContextSaveGState(ctx);
    // 图形上下文形变，避免图片倒立显示
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextTranslateCTM(ctx, 0.0, -150.0);
    // 图片
    UIImage *image = [UIImage imageNamed:@"location"];
    CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, 15.0, 20.0), image.CGImage);
    CGContextRestoreGState(ctx);
}

@end
