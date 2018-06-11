//
//  GrphaView.h
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraduationLayer.h"
#import <Foundation/Foundation.h>
#import "BaseLineLayer.h"
#import "GraphLayer.h"
/**
 视图层
 */
@interface GrphaView : UIView
{
    GraduationLayer *graduationLayer;   //坐标系
    BaseLineLayer   *baseLineLayer;     //基准线
    GraphLayer      *graphLayer;        //折线图
    

}


@end
