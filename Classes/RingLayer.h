//
//  RingLayer.h
//  Graph
//
//  Created by yaoln on 2018/6/11.
//  Copyright © 2018年 zz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/**
 环形类
 */
@interface RingLayer : CALayer
{
    UIColor *ringColor;     //环形的颜色
    UIColor *centreColor;   //环形圆心的颜色
}

@property (nonatomic, assign) CGPoint point;       //圆环的圆心坐标


@end
