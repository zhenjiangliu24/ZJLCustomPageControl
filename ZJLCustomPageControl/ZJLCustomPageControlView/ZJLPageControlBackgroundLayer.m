//
//  ZJLPageControlBackgroundLayer.m
//  ZJLCustomPageControl
//
//  Created by ZhongZhongzhong on 16/6/23.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import "ZJLPageControlBackgroundLayer.h"
static const NSInteger defaultNumberOfPages = 3;
static const NSInteger defaultCurrentPage = 1;
static const CGFloat defaultCircleDiameter = 10.0;
#define DefaultCircleColor [UIColor lightGrayColor]

@implementation ZJLPageControlBackgroundLayer
- (instancetype)init
{
    if (self = [super init]) {
        _numberOfPages = defaultNumberOfPages;
        _currentPage = defaultCurrentPage;
        _circleColor = DefaultCircleColor;
        _circleDiameter = defaultCircleDiameter;
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    if(_currentPage<=0){
        _currentPage = 1;
    }
    if(_currentPage>_numberOfPages){
        _currentPage = _numberOfPages;
    }
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGMutablePathRef linePath = CGPathCreateMutable();
    CGFloat circleDistance = self.frame.size.width/(self.numberOfPages+1);
    for (int i = 0; i<_numberOfPages; i++) {
        if (i==_currentPage-1) {
            continue;
        }
        CGPathAddEllipseInRect(linePath, NULL, CGRectMake((i+1)*circleDistance-self.circleDiameter*0.5, (self.frame.size.height-self.circleDiameter)*0.5, self.circleDiameter, self.circleDiameter));
    }
    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, self.circleColor.CGColor);
    CGContextFillPath(ctx);
}
@end
