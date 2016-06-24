//
//  ZJLCircleLayer.h
//  ZJLCustomPageControl
//
//  Created by ZhongZhongzhong on 16/6/24.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ZJLCircleLayer : CALayer
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, assign) CGFloat offset_x;
@property (nonatomic, assign) CGFloat preOffset_x;
@property (nonatomic, assign) CGFloat bindingViewWidth;
- (instancetype)initWithFrame:(CGRect)frame;
@end
