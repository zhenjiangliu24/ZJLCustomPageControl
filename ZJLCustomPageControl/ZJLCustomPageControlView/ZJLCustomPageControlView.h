//
//  ZJLCustomPageControlView.h
//  ZJLCustomPageControl
//
//  Created by ZhongZhongzhong on 16/6/24.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJLCustomPageControlView : UIView
@property (nonatomic, strong) UIScrollView *bindingView;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat offset_x;
@property (nonatomic, assign) CGFloat preOffset_x;
@end
