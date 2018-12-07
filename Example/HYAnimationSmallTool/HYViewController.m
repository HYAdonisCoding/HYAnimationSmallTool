//
//  HYViewController.m
//  HYAnimationSmallTool
//
//  Created by HYAdonisCoding on 12/07/2018.
//  Copyright (c) 2018 HYAdonisCoding. All rights reserved.
//

#import "HYViewController.h"
#import "HYBubbleView.h"

@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    HYBubbleView *view = [[HYBubbleView alloc] initWithFrame:CGRectMake(100, 200, 50, 60)];
    view.numberString = @"99+";
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
