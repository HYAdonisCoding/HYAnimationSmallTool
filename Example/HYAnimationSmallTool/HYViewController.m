//
//  HYViewController.m
//  HYAnimationSmallTool
//
//  Created by HYAdonisCoding on 12/07/2018.
//  Copyright (c) 2018 HYAdonisCoding. All rights reserved.
//

#import "HYViewController.h"
#import <HYAnimationSmallTool/HYAnimationSmallTool.h>

@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self loadBubbleView];
    
    [self loadLikeView];
    
}

- (void)loadLikeView {
    HYLikeView *view = [[HYLikeView alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
    
    view.isLikeBlock = ^(BOOL isLike) {
        if (isLike) {
            NSLog(@"%s--%@", __func__, @"点赞");
        } else {
            NSLog(@"%s--%@", __func__, @"取消点赞");
        }
    };
    [self.view addSubview:view];
}

- (void)loadBubbleView {
    HYBubbleView *view = [[HYBubbleView alloc] initWithFrame:CGRectMake(100, 200, 50, 60)];
    view.numberString = @"99+";
    view.finishedBlock = ^(id data) {
        if ([data isKindOfClass:[UIPanGestureRecognizer class]]) {
            UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)data;
            
            if (pan.state == UIGestureRecognizerStateEnded) {
                NSLog(@"%s--%@", __func__, @"结束了");
            } else if (pan.state == UIGestureRecognizerStateCancelled) {
                NSLog(@"%s--%@", __func__, @"取消了");
            } else if (pan.state == UIGestureRecognizerStateFailed) {
                NSLog(@"%s--%@", __func__, @"失败了");
            }
            
        }
    };
    //    view.isDisappearInFinished = YES;
    [self.view addSubview:view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
