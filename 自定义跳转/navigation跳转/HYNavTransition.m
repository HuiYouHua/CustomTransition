//
//  HYNavTransition.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/30.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYNavTransition.h"
#import "HYNavOneViewController.h"
#import "HYNavTwoViewController.h"
#import "HYNavCell.h"

@implementation HYNavTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .8;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    HYNavTwoViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    HYNavOneViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containView = [transitionContext containerView];
    
    // 记录选中的cell
    NSIndexPath *indexPath = [fromVc.tableView indexPathForSelectedRow];
    fromVc.indexPath = indexPath;
    HYNavCell *cell = (HYNavCell *)[fromVc.tableView cellForRowAtIndexPath:indexPath];
    
    // 截图将要放大的图片
    UIView *screenShot = [cell.headView snapshotViewAfterScreenUpdates:NO];
    screenShot.backgroundColor = [UIColor clearColor];
    // 获取截图在中间视图上的坐标
    screenShot.frame = fromVc.finiRect = [containView convertRect:cell.headView.frame fromView:cell.headView.superview];
    cell.headView.hidden = YES;
    
    // 添加目标视图及变化视图
    toVc.view.frame = [transitionContext finalFrameForViewController:toVc];
    toVc.view.alpha = 0.5;
    toVc.imageView.hidden = YES;
    [containView addSubview:toVc.view];
    [containView addSubview:screenShot];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containView layoutIfNeeded];
        
        fromVc.view.alpha = 1;
        screenShot.frame = [containView convertRect:toVc.imageView.frame toView:toVc.imageView.superview];
    } completion:^(BOOL finished) {
        toVc.imageView.hidden = NO;
        cell.headView.hidden = NO;
        
        [screenShot removeFromSuperview];
        toVc.view.alpha = 1;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end








