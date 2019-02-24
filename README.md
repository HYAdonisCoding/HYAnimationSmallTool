# HYAnimationSmallTool

[![CI Status](https://img.shields.io/travis/HYAdonisCoding/HYAnimationSmallTool.svg?style=flat)](https://travis-ci.org/HYAdonisCoding/HYAnimationSmallTool)
[![Version](https://img.shields.io/cocoapods/v/HYAnimationSmallTool.svg?style=flat)](https://cocoapods.org/pods/HYAnimationSmallTool)
[![License](https://img.shields.io/cocoapods/l/HYAnimationSmallTool.svg?style=flat)](https://cocoapods.org/pods/HYAnimationSmallTool)
[![Platform](https://img.shields.io/cocoapods/p/HYAnimationSmallTool.svg?style=flat)](https://cocoapods.org/pods/HYAnimationSmallTool)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Example Code

#### HYBubleView
```
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
    //view.isDisappearInFinished = YES;
    [self.view addSubview:view];
```
#### HYLikeView
```
HYLikeView *view = [[HYLikeView alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
    
    view.isLikeBlock = ^(BOOL isLike) {
        if (isLike) {
            NSLog(@"%s--%@", __func__, @"点赞");
        } else {
            NSLog(@"%s--%@", __func__, @"取消点赞");
        }
    };
    [self.view addSubview:view];
```
## Requirements

## Installation

HYAnimationSmallTool is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HYAnimationSmallTool'
```

## Author

HYAdonisCoding, 296786475@qq.com

## License

HYAnimationSmallTool is available under the MIT license. See the LICENSE file for more info.
