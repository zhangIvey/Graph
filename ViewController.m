//
//  ViewController.m
//  Graph
//
//  Created by yaoln on 2018/6/8.
//  Copyright © 2018年 zz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) GrphaView *grphaView;

@end

@implementation ViewController



-(GrphaView *)grphaView {
    if (_grphaView == nil) {
        _grphaView = [[GrphaView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500)];
    }
    return _grphaView;

}


- (void)viewDidLoad {
    [super viewDidLoad];


    //添加背景图层
    UIColor *color1 = [UIColor colorWithRed:1/225.0 green:160/255.0 blue:241/255.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:138/255.0 green:209/255.0 blue:243/255.0 alpha:1];
    [self.view.layer addSublayer:[self backgroundColorChangeFrom:color1 to:color2]];

    self.view.backgroundColor = [UIColor greenColor];
    self.grphaView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.grphaView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 设置数据图的背景色渐变效果

 @param c1 开始的色值
 @param c2 渐变之后的色值
 */
- (CAGradientLayer *)backgroundColorChangeFrom:(UIColor *)c1 to:(UIColor *)c2
{
    CAGradientLayer *backgroundLayer = [CAGradientLayer layer];
    backgroundLayer.frame = self.view.bounds;
    backgroundLayer.colors = @[(__bridge id)c1.CGColor,
                               (__bridge id)c2.CGColor];
    backgroundLayer.startPoint = CGPointMake(0.5, 0);
    backgroundLayer.endPoint = CGPointMake(0.5, 1);
    backgroundLayer.type = kCAGradientLayerAxial;

    return backgroundLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
