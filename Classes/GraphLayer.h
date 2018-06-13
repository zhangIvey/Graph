//
//  GraphLayer.h
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RingLayer.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ClickAreaLayer.h"
#import "RingLayer.h"
/**
 折线图类
 */
@interface GraphLayer : CALayer
{
    NSMutableArray<RingLayer *>         *rings;

    CAGradientLayer *graphColor;
}
@property(nonatomic, strong) NSArray<NSNumber *> *stepsPercent;  //步数/10000
@property(nonatomic, strong) NSMutableArray<ClickAreaLayer *>    *clickLayers;

@end
