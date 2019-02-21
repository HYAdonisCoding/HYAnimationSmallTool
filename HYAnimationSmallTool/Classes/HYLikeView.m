//
//  HYLikeView.m
//  Adam_20190221_Like
//
//  Created by Adonis_HongYang on 2019/2/21.
//  Copyright © 2019年 Nikoyo (China）Electronics Systems Co., Ltd. All rights reserved.
//

#import "HYLikeView.h"
#import "UIImage+HYBundle.h"

#define kFavoriteViewLikeBeforeTag 1 //点赞
#define kFavoriteViewLikeAfterTag  2 //取消点赞

@implementation HYLikeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        
        CGRect rect = CGRectMake(0, 0, MIN(width, height), MIN(width, height) * .9f);
        rect = self.bounds;
        _likeBefore = [[UIImageView alloc] initWithFrame:rect];
        _likeBefore.contentMode = UIViewContentModeScaleAspectFit;
        _likeBefore.image = [UIImage hy_imgWithName:@"icon_like_before" bundle:@"HYAnimationSmallTool" targetClass:[self class]];
        _likeBefore.userInteractionEnabled = YES;
        _likeBefore.tag = kFavoriteViewLikeBeforeTag;
        [_likeBefore addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_likeBefore];
        
        
        _likeAfter = [[UIImageView alloc] initWithFrame:rect];
        _likeAfter.contentMode = UIViewContentModeScaleAspectFit;
        _likeAfter.image = [UIImage hy_imgWithName:@"icon_like_after" bundle:@"HYAnimationSmallTool" targetClass:[self class]];
        _likeAfter.userInteractionEnabled = YES;
        _likeAfter.tag = kFavoriteViewLikeAfterTag;
        [_likeAfter setHidden:YES];
        [_likeAfter addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_likeAfter];
    }
    return self;
}

- (void)handleGesture:(UITapGestureRecognizer *)tapGR {
    switch (tapGR.view.tag) {
        case kFavoriteViewLikeBeforeTag:
            //点赞
            [self startLikeAnimations:YES];
            break;
        case kFavoriteViewLikeAfterTag:
            //取消点赞
            [self startLikeAnimations:NO];
            break;
        default:
            break;
    }
}

- (void)startLikeAnimations:(BOOL)isLike {
    
    _likeBefore.userInteractionEnabled = NO;
    _likeAfter.userInteractionEnabled = NO;
    
    if (isLike) {
        CGFloat length = CGRectGetHeight(self.frame) * .6f;
        CGFloat width = CGRectGetWidth(self.frame) * .06f;
        CGFloat duration = self.likeDuration > 0 ? self.likeDuration : .5f;
        for (int i = 0; i < 6; i++) {
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.position = _likeBefore.center;
            layer.fillColor = self.likeFillColor == nil ? [UIColor redColor].CGColor : self.likeFillColor.CGColor;
            
            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-width, -length)];
            [startPath addLineToPoint:CGPointMake(width, -length)];
            [startPath addLineToPoint:CGPointMake(.0f, .0f)];
            layer.path = startPath.CGPath;
            layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, .0f, .0f, 1.0f);
            [self.layer addSublayer:layer];
            
            CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
            group.removedOnCompletion = NO;
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            group.fillMode = kCAFillModeForwards;
            group.duration = duration;
            
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @(0.0f);
            scaleAnimation.toValue = @(1.0f);
            scaleAnimation.duration = duration * .2f;
            
            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-width, -length)];
            [endPath addLineToPoint:CGPointMake(width, -length)];
            [endPath addLineToPoint:CGPointMake(.0f, -length)];
            
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnimation.fromValue = (__bridge id _Nullable)(layer.path);
            pathAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
            pathAnimation.beginTime = duration * .2f;
            pathAnimation.duration = duration * .8f;
            [group setAnimations:@[scaleAnimation, pathAnimation]];
            [layer addAnimation:group forKey:nil];
            
            [_likeAfter setHidden:NO];
            _likeAfter.alpha = .0f;
            _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI/3*2), .5f, .5f);
            [UIView animateWithDuration:.4f delay:.2f usingSpringWithDamping:.6f initialSpringVelocity:.8f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                self.likeBefore.alpha = .0f;
                self.likeAfter.alpha = 1.0f;
                self.likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
            } completion:^(BOOL finished) {
                self.likeBefore.alpha = 1.0f;
                self.likeBefore.userInteractionEnabled = YES;
                self.likeAfter.userInteractionEnabled = YES;
            }];
            
            
        }
    } else {
        
        _likeAfter.alpha = 1.0f;
        _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
        
        [UIView animateWithDuration:.35f delay:.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            self.likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI_4), .1f, .1f);
        } completion:^(BOOL finished) {
            [self.likeAfter setHidden:YES];
            self.likeBefore.userInteractionEnabled = YES;
            self.likeAfter.userInteractionEnabled = YES;
        }];
    }
    
    if (self.isLikeBlock) {
        self.isLikeBlock(isLike);
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
