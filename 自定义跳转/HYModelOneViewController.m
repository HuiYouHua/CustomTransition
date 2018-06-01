//
//  HYModelOneViewController.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/30.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYModelOneViewController.h"
#import "HYModelTwoViewController.h"

#import "HYModelTransition.h"
#import "HYModelDismisTransition.h"
@interface HYModelOneViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) HYModelTransition *transition;
@property (nonatomic, strong) HYModelDismisTransition *dissTransition;

@end

@implementation HYModelOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
    [btn1 setTitle:@"跳转" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(model) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 30)];
    [btn2 setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
}

- (void)model {
    HYModelTwoViewController *vc = [HYModelTwoViewController new];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
/* presentViewController过度动画 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (!_transition) {
        _transition = [HYModelTransition new];
    }
    return _transition;
}

/* dismissViewControllerAnimated过度动画 */
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (!_dissTransition) {
        _dissTransition = [HYModelDismisTransition new];
    }
    return _dissTransition;
}

/* presentViewController手势动画 */
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;

/* dismissViewControllerAnimated手势动画 */
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;

@end
