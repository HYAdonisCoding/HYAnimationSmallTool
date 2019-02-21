//
//  UIImage+HYBundle.h
//  Adam_20190221_Like
//
//  Created by Adonis_HongYang on 2019/2/21.
//  Copyright © 2019年 Nikoyo (China）Electronics Systems Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HYBundle)

/**
 获取bundle中的图片

 @param name 图片名称
 @param bundleName bundle
 @param targetClass targetClass
 @return 图片
 */
+ (instancetype)hy_imgWithName:(NSString *)name bundle:(NSString *)bundleName targetClass:(Class)targetClass;

@end

NS_ASSUME_NONNULL_END
