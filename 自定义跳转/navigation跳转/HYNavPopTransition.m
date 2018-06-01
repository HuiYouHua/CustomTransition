//
//  HYNavPopTransition.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/31.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYNavPopTransition.h"
#import "HYNavOneViewController.h"
#import "HYNavTwoViewController.h"
#import "HYNavCell.h"

@implementation HYNavPopTransition
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .8;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    HYNavOneViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    HYNavTwoViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containView = [transitionContext containerView];
    
    
    UIView *screenShot = [fromVc.imageView snapshotViewAfterScreenUpdates:NO];
    screenShot.backgroundColor = [UIColor clearColor];
    screenShot.frame = [containView convertRect:fromVc.imageView.frame fromView:fromVc.imageView.superview];
    fromVc.imageView.hidden = YES;
    
    toVc.view.frame = [transitionContext finalFrameForViewController:toVc];

    HYNavCell *cell = (HYNavCell *)[toVc.tableView cellForRowAtIndexPath:toVc.indexPath];
    cell.headView.hidden = YES;
    
    [containView insertSubview:toVc.view belowSubview:fromVc.view];
    [containView addSubview:screenShot];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{

        fromVc.view.alpha = 0;
        screenShot.frame = toVc.finiRect;
    } completion:^(BOOL finished) {
        fromVc.imageView.hidden = NO;
        cell.headView.hidden = NO;
        
        [screenShot removeFromSuperview];
        fromVc.view.alpha = 1;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
