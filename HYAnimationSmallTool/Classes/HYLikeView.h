//
//  HYLikeView.h
//  Adam_20190221_Like
//
//  Created by Adonis_HongYang on 2019/2/21.
//  Copyright © 2019年 Nikoyo (China）Electronics Systems Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HYLikeBlock)(BOOL isLike);

NS_ASSUME_NONNULL_BEGIN

@interface HYLikeView : UIView

/** 点赞前的图片 */
@property (nonatomic, strong) UIImageView *likeBefore;

/** 点赞后的图片 */
@property (nonatomic, strong) UIImageView *likeAfter;

/** 点赞时长 */
@property (nonatomic, assign) CGFloat likeDuration;

/** 点赞按钮填充颜色 */
@property (nonatomic, strong) UIColor *likeFillColor;

/** 点赞的回调 */
@property (nonatomic, copy) HYLikeBlock isLikeBlock;


@end

NS_ASSUME_NONNULL_END
