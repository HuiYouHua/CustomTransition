//
//  HYModelDismisTransition.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/31.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYModelDismisTransition.h"

@implementation HYModelDismisTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .8;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVc];
    
    toVc.view.frame = CGRectOffset(finalFrame, 0, finalFrame.size.height);
    [[transitionContext containerView] addSubview:toVc.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            toVc.view.frame = finalFrame;
                        } completion:^(BOOL finished) {
                            [transitionContext completeTransition:YES];
                        }];
}

@end
