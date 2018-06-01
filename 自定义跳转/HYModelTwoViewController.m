//
//  HYModelTwoViewController.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/30.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYModelTwoViewController.h"
#import "HYModelDismisTransition.h"
@interface HYModelTwoViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation HYModelTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 30)];
    [btn2 setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    // 添加屏幕边缘手势
    UIScreenEdgePanGestureRecognizer *edgePagGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeAction:)];
    edgePagGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePagGesture];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 
 // 添加手势驱动
 
 iOS7 新加入一个类对象 UIPercentDrivenInteractiveTransition ;这个对象会根据我们的手势，来决定我们界面跳转的自定义过渡效果，我们在手势action方法中，对手势驱动状态进行判断，来决定是否过渡动画。
 
 */

- (void)edgeAction:(UIScreenEdgePanGestureRecognizer *)sender
{
    // 计算手指滑动的距离
    
    // 计算手势驱动占屏幕的百分比
    CGFloat distance = [sender translationInView:sender.view].x / self.view.bounds.size.width;
    distance = MIN(1.0, MAX(0.0, distance));
    // 限制百分比 0 - 1 之间
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self dismissViewControllerAnimated:YES completion:Nil];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        // 手势在慢慢划入 // 把手势的进度告诉 UIPercentDrivenInteractiveTransition
        [self.percentDrivenTransition updateInteractiveTransition:distance];
    } else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        if (distance > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        } else {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if ([animator isKindOfClass:[HYModelDismisTransition class]]) {
        return self.percentDrivenTransition;
    }
    else
    {
        return nil;
    }
}

@end
