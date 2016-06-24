//
//  ZJLCircleLayer.m
//  ZJLCustomPageControl
//
//  Created by ZhongZhongzhong on 16/6/24.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import "ZJLCircleLayer.h"

typedef NS_ENUM(NSInteger,MOVE_DIRECTION){
    MOVE_LEFT,
    MOVE_RIGHT
};

static const CGFloat defaultProgress = 0.0;
static const NSInteger defaultNumberOfPages = 3;
static const NSInteger defaultCurrentPage = 0;
static const CGFloat circleDiameter = 10.0;

@interface ZJLCircleLayer()
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat circleDistance;
@property (nonatomic, assign) MOVE_DIRECTION direction;
@property (nonatomic, assign) CGRect circleBounds;
@end

@implementation ZJLCircleLayer
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        _numberOfPages = defaultNumberOfPages;
        _currentPage = defaultCurrentPage;
        _progress = defaultProgress;
        self.frame = frame;
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    _circleDistance = self.frame.size.width/(numberOfPages+1);
}

- (void)setPreOffset_x:(CGFloat)preOffset_x
{
    _preOffset_x = preOffset_x;
}


- (void)setOffset_x:(CGFloat)offset_x
{
    _offset_x = offset_x;
    CGFloat totalWidth = _bindingViewWidth;
    if (_offset_x>_preOffset_x) {
        self.direction = MOVE_RIGHT;
        if (_offset_x/totalWidth<=_preOffset_x/totalWidth+0.5) {
            _progress = MIN(1, MAX(0, _circleDistance/totalWidth));
        }else{
            _progress = 1-MIN(1, MAX(0, _circleDistance/totalWidth));
        }
    }else{
        self.direction = MOVE_LEFT;
        NSInteger last = _currentPage/totalWidth+2;
        if (_offset_x>0 && _offset_x<=totalWidth*(last-1.5)) {
            _progress = 1-MIN(1, MAX(0, _circleDistance/totalWidth));
        }else{
            _progress = MIN(1, MAX(0, _circleDistance/totalWidth));
        }
        if (_progress>0.9) {
            _progress = 0;
        }
    }
    CGFloat origin_x = (self.offset_x / _bindingViewWidth)*(self.frame.size.width / (_numberOfPages + 1)) + _circleDistance - circleDiameter * .5;
    CGFloat origin_y = self.position.y - circleDiameter * .5;
    self.circleBounds = CGRectMake(origin_x, origin_y, circleDiameter, circleDiameter);
    
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGFloat offset = self.circleBounds.size.width / 3.6;
    CGFloat moveDistance = (self.circleBounds.size.width / 6) * fabs(self.progress) * 2;
    CGPoint rectCenter = CGPointMake(self.circleBounds.origin.x + self.circleBounds.size.width * .5, self.circleBounds.origin.y + self.circleBounds.size.height * .5);
    CGPoint point_A = CGPointMake(rectCenter.x,self.circleBounds.origin.y + moveDistance);
    CGPoint point_B = CGPointMake(self.direction == MOVE_RIGHT ? rectCenter.x + self.circleBounds.size.width * .5:self.circleBounds.size.width * .5 + rectCenter.x + moveDistance * 2, rectCenter.y);
    CGPoint point_C = CGPointMake(rectCenter.x, rectCenter.y + self.circleBounds.size.width * .5 - moveDistance);
    CGPoint point_D = CGPointMake(self.direction == MOVE_RIGHT ? self.circleBounds.origin.x - moveDistance * 2:self.circleBounds.origin.x, rectCenter.y);
    CGPoint point_c1 = CGPointMake(point_A.x + offset, point_A.y);
    CGPoint point_c2 = CGPointMake(point_B.x,self.direction == MOVE_RIGHT ? point_B.y - offset:point_B.y - offset + moveDistance);
    CGPoint point_c3 = CGPointMake(point_B.x, self.direction == MOVE_RIGHT ? point_B.y + offset:point_B.y + offset - moveDistance);
    CGPoint point_c4 = CGPointMake(point_C.x + offset, point_C.y);
    CGPoint point_c5 = CGPointMake(point_C.x - offset, point_C.y);
    CGPoint point_c6 = CGPointMake(point_D.x, self.direction == MOVE_RIGHT ? point_D.y + offset - moveDistance:point_D.y + offset);
    CGPoint point_c7 = CGPointMake(point_D.x, self.direction == MOVE_RIGHT ? point_D.y - offset + moveDistance:point_D.y - offset);
    CGPoint point_c8 = CGPointMake(point_A.x - offset,point_A.y);
    
    UIBezierPath *ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint:point_A];
    [ovalPath addCurveToPoint:point_B controlPoint1:point_c1 controlPoint2:point_c2];
    [ovalPath addCurveToPoint:point_C controlPoint1:point_c3 controlPoint2:point_c4];
    [ovalPath addCurveToPoint:point_D controlPoint1:point_c5 controlPoint2:point_c6];
    [ovalPath addCurveToPoint:point_A controlPoint1:point_c7 controlPoint2:point_c8];
    [ovalPath closePath];
    CGContextAddPath(ctx, ovalPath.CGPath);
    //    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, self.circleColor.CGColor);
    CGContextFillPath(ctx);
}
@end
