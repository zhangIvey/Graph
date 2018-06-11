//
//  GraduationLayer.h
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GraphLayer.h"
/**
 纵轴和横轴的刻度标示
 */
@interface GraduationLayer : CALayer
{
    GraphLayer                        *graphLayer;
    NSMutableArray<CATextLayer *>     *scaleXLabels;      //X轴刻度集合

}
@property(nonatomic, strong) NSArray *scalexX;
@property(nonatomic, strong) NSArray *scalesY;

@end
