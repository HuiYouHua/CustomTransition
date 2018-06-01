//
//  HYModelTransition.h
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/30.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HYModelTransition : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (strong , nonatomic) id <UIViewControllerContextTransitioning> transitionContext;

@end
