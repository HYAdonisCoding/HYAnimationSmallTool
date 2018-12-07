//
//  HYBubbleView.m
//  Adonis_20181203_Customer_TransfromAnimation
//
//  Created by Adonis_HongYang on 2018/12/6.
//  Copyright © 2018年 Nikoyo (China）Electronics Systems Co., Ltd. All rights reserved.
//

#import "HYBubbleView.h"

@interface  HYBubbleView ()

/** 小气泡 */
@property (nonatomic, strong) UIView *view1;
/** 大气泡 */
@property (nonatomic, strong) UIView *view2;
/** 数字 */
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGPoint oldViewCenter;
@property (nonatomic, assign) CGRect oldViewFrame;
@property (nonatomic, assign) CGFloat r1;

@end

@implementation HYBubbleView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

//    return [super hitTest:point withEvent:event];
    return [self getTargetView:self point:point event:event];
}

- (UIView *)getTargetView:(UIView *)view
                    point:(CGPoint)point
                    event:(UIEvent *)event {
    
    __block UIView *subView;
    
    //逆序 由层级最低 也就是最上层的子视图开始
    [view.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //point 从view 转到 obj中
        CGPoint hitPoint = [obj convertPoint:point fromView:view];
        //        NSLog(@"%@ - %@",NSStringFromCGPoint(point),NSStringFromCGPoint(hitPoint));
        
        if([obj pointInside:hitPoint withEvent:event])//在当前视图范围内
        {
            if(obj.subviews.count != 0)
            {
                //如果有子视图 递归
                subView = [self getTargetView:obj point:hitPoint event:event];
                
                if(!subView)
                {
                    //如果没找到 提交当前视图
                    subView = obj;
                }
            }
            else
            {
                subView = obj;
            }
            
            *stop = YES;
        }
        else//不在当前视图范围内
        {
            if(obj.subviews.count != 0)
            {
                //如果有子视图 递归
                subView = [self getTargetView:obj point:hitPoint event:event];
            }
        }
        
    }];
    
    return subView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    if (width != height) {
        width = width < height ? width : height;
    }
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, width, width)];
    
    if (self) {
        [self makeInterface];
    }
    return self;
}

- (void)setNumberString:(NSString *)numberString {
    _numberString = numberString;
    _numberLabel.text = numberString;
}

- (void)makeInterface {
    self.view1 = [[UIView alloc] initWithFrame:self.bounds];
    self.view1.backgroundColor = [UIColor redColor];
    self.view1.layer.cornerRadius = CGRectGetWidth(self.bounds) * .5;
    self.view1.layer.masksToBounds = YES;
    [self addSubview:self.view1];
    
    self.view2 = [[UIView alloc] initWithFrame:self.bounds];
    self.view2.backgroundColor = [UIColor redColor];
    self.view2.layer.cornerRadius = CGRectGetWidth(self.bounds) * .5;
    self.view2.layer.masksToBounds = YES;
    [self addSubview:self.view2];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.textColor = [UIColor whiteColor];
    [self.view2 addSubview:self.numberLabel];
    
    
    UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveAction:)];
    [self.view2 addGestureRecognizer:gr];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [UIColor redColor].CGColor;
    self.oldViewFrame = self.view1.frame;
    self.oldViewCenter = self.view1.center;
    self.r1 = CGRectGetWidth(self.view1.frame) * .5;
    
}

- (void)moveAction:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.view2.center = [gestureRecognizer locationInView:self];
        
        if (self.r1 < 9) {
            self.view1.hidden = YES;
            [self.shapeLayer removeFromSuperlayer];
        } else {
            
            [self calculateAndDrawUp];
        }
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateFailed ||
               gestureRecognizer.state == UIGestureRecognizerStateEnded ||
               gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        [self.shapeLayer removeFromSuperlayer];
        [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.3 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.view2.center = self.oldViewCenter;
        } completion:^(BOOL finished) {
            self.view1.hidden = NO;
            self.view1.frame = self.oldViewFrame;
            self.r1 = self.oldViewFrame.size.width * .5;
            self.view1.layer.cornerRadius = self.r1;
        }];
    }
}

- (void)calculateAndDrawUp {
    CGPoint center1 = self.view1.center;
    CGPoint center2 = self.view2.center;
    //2.求出中心点的距离
    CGFloat dis = sqrtf((center1.x - center2.x)*(center1.x - center2.x) + (center1.y - center2.y) * (center1.y - center2.y));
    //3.计算正玄余玄
    CGFloat sin = (center2.x - center1.x)/dis;
    CGFloat cos = (center1.y - center2.y)/dis;
    //4.半径
    CGFloat r1 = CGRectGetWidth(self.oldViewFrame) *.5 - dis/20;
    CGFloat r2 = CGRectGetWidth(self.view2.bounds)*.5;
    _r1 = r1;
    //5.计算点坐标
    CGPoint pA = CGPointMake(center1.x - r1*cos, center1.y - r1*sin);
    CGPoint pB = CGPointMake(center1.x + r1*cos, center1.y + r1*sin);
    CGPoint pC = CGPointMake(center2.x + r2*cos, center2.y + r2*sin);
    CGPoint pD = CGPointMake(center2.x - r2*cos, center2.y - r2*sin);
    CGPoint pO = CGPointMake(pA.x + dis*.5*sin, pA.y - dis*.5*cos);
    CGPoint pP = CGPointMake(pB.x + dis*.5*sin, pB.y - dis*.5*cos);
    
    //6.画贝塞尔取现
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pA];
    [path addQuadCurveToPoint:pD controlPoint:pO];
    [path addLineToPoint:pC];
    [path addQuadCurveToPoint:pB controlPoint:pP];
    [path closePath];
    
    if (!self.view1.hidden) {
        
        //7.把路径绘制到layer上
        self.shapeLayer.path = path.CGPath;
        [self.layer insertSublayer:self.shapeLayer below:self.view2.layer];
    }
    
    //重写计算view1的位置
    self.view1.center = self.oldViewCenter;
    self.view1.bounds = CGRectMake(0, 0, r1*2, r1*2);
    self.view1.layer.cornerRadius = r1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
