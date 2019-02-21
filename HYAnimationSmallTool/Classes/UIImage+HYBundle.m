//
//  UIImage+HYBundle.m
//  Adam_20190221_Like
//
//  Created by Adonis_HongYang on 2019/2/21.
//  Copyright © 2019年 Nikoyo (China）Electronics Systems Co., Ltd. All rights reserved.
//

#import "UIImage+HYBundle.h"

@implementation UIImage (HYBundle)

+ (instancetype)hy_imgWithName:(NSString *)name bundle:(NSString *)bundleName targetClass:(Class)targetClass {
    NSInteger scale = [[UIScreen mainScreen] scale];
    NSBundle *curB = [NSBundle bundleForClass:targetClass];
    NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", name,scale];
    NSString *dir = [NSString stringWithFormat:@"%@.bundle",bundleName];
    NSString *path = [curB pathForResource:imgName ofType:nil inDirectory:dir];
    return path?[UIImage imageWithContentsOfFile:path]:nil;
}

@end
