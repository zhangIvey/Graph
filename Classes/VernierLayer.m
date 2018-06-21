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
        image = [UIImage imageNamed:@"location"];
    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx
{
    CGRect imageRect;
    imageRect.origin = CGPointMake(0.0, 0.0);
    imageRect.size = self.bounds.size;
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -self.bounds.size.height);
    CGContextDrawImage(ctx, imageRect, image.CGImage);
}

@end
