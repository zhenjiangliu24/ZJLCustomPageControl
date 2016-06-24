//
//  ZJLPageControlBackgroundLayer.h
//  ZJLCustomPageControl
//
//  Created by ZhongZhongzhong on 16/6/23.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ZJLPageControlBackgroundLayer : CALayer
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CGFloat circleDiameter;
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, strong) UIView *bindingView;
@end
