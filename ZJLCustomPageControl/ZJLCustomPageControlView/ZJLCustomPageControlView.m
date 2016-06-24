//
//  ZJLCustomPageControlView.m
//  ZJLCustomPageControl
//
//  Created by ZhongZhongzhong on 16/6/24.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import "ZJLCustomPageControlView.h"
#import "ZJLCircleLayer.h"
#import "ZJLPageControlBackgroundLayer.h"

@interface ZJLCustomPageControlView()
@property (nonatomic, strong) ZJLCircleLayer *circleLayer;
@property (nonatomic, strong) ZJLPageControlBackgroundLayer *backLayer;
@end


@implementation ZJLCustomPageControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _backLayer = [ZJLPageControlBackgroundLayer layer];
        _backLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _backLayer.bindingView = _bindingView;
        [self.layer addSublayer:_backLayer];
        
        _circleLayer = [[ZJLCircleLayer alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:_circleLayer];
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    _backLayer.numberOfPages = numberOfPages;
    _circleLayer.numberOfPages = numberOfPages;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    _backLayer.currentPage = currentPage;
    _circleLayer.currentPage = currentPage;
    
}

- (void)setPreOffset_x:(CGFloat)preOffset_x
{
    _preOffset_x = preOffset_x;
    _circleLayer.preOffset_x = preOffset_x;
}

- (void)setOffset_x:(CGFloat)offset_x
{
    _offset_x = offset_x;
    _circleLayer.offset_x = offset_x;
    [self calculateProgress];
}

- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    _backLayer.circleColor = backColor;
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    _circleLayer.circleColor = selectedColor;
}


- (void)calculateProgress {
    
    CGFloat pageWidth = self.bindingView.frame.size.width;
    int currentPage = floor((self.offset_x - pageWidth * .5) / pageWidth) + 2;
    self.currentPage = currentPage;
}

- (void)setBindingView:(UIScrollView *)bindingView
{
    _bindingView = bindingView;
    _circleLayer.bindingViewWidth = bindingView.frame.size.width;
    _circleLayer.offset_x = 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
