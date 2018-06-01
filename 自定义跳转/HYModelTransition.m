//
//  HYModelTransition.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/30.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYModelTransition.h"

#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width

@implementation HYModelTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .8;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    // 目标控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 来源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect circleCenterRect = CGRectMake(120, 320, 50, 50);
    
    // 小圆
    UIBezierPath *smallCirclePath = [UIBezierPath bezierPathWithOvalInRect:circleCenterRect];
    
    // 大圆
    CGFloat centerX = circleCenterRect.origin.x + circleCenterRect.size.width/2.0;
    CGFloat centerY = circleCenterRect.origin.y + circleCenterRect.size.height/2.0;
    CGFloat r1 = (kScreenWidth - centerX) > centerX ? (kScreenWidth - centerX) : centerX;
    CGFloat r2 = (kScreenHeight - centerY) > centerY ? (kScreenHeight - centerY) : centerY;
    CGFloat radius = sqrt((r1*r1) + (r2*r2));
    UIBezierPath *bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(circleCenterRect, -radius, -radius)];
    
    // 在中间视图上添加目标控制器的视图
    [[transitionContext containerView] addSubview:toVc.view];
    
    // 添加动画视图layer
    CAShapeLayer *layer = [CAShapeLayer layer];
    toVc.view.layer.mask = layer;
    layer.path = bigCirclePath.CGPath;
    
    // 执行动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(smallCirclePath.CGPath);
    animation.toValue = (__bridge id _Nullable)(bigCirclePath.CGPath);
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    [layer addAnimation:animation forKey:@"path"];
}

// 当动画结束后，通知过度动画结束，并关闭相关视图资源
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewKey].view.layer.mask = nil;
}

@end









