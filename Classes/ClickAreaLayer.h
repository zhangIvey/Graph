//
//  ClickAreaLayer.h
//  Graph
//
//  Created by yaoln on 2018/6/11.
//  Copyright © 2018年 zz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RingLayer.h"

/**
 响应反馈区域类
 */
@interface ClickAreaLayer : CALayer
{
    CAGradientLayer  *backgroundLayer;
}

@property(nonatomic, strong) UIColor  *selectedColor;

@end
