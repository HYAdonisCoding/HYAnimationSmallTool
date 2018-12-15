//
//  HYBubbleView.h
//  Adonis_20181203_Customer_TransfromAnimation
//
//  Created by Adonis_HongYang on 2018/12/6.
//  Copyright © 2018年 Nikoyo (China）Electronics Systems Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYAnimationSmallTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBubbleView : UIView

/** 消息数 */
@property (nonatomic, copy) NSString *numberString;

/** 完成后的操作 返回数据为手势,可根据手势的state做个性化操作 */
@property (nonatomic, copy) FinishedBlock finishedBlock;

/** 完成后是否消失 */
@property (nonatomic, assign) BOOL isDisappearInFinished;


@end

NS_ASSUME_NONNULL_END
