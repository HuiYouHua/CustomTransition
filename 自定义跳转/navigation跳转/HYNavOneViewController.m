//
//  HYNavOneViewController.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/31.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYNavOneViewController.h"

#import "HYNavTwoViewController.h"
#import "HYNavTransition.h"
#import "HYNavCell.h"
#import "HYNavPopTransition.h"

@interface HYNavOneViewController ()<UITableViewDelegate, UITableViewDataSource ,UINavigationControllerDelegate>


@end

@implementation HYNavOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"One";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
//    [btn1 setTitle:@"跳转" forState:UIControlStateNormal];
//    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(model) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:@"HYNavCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(300, 100, 50, 30)];
    [btn2 setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYNavCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HYNavTwoViewController *vc = [HYNavTwoViewController new];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}


//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0) {
//
//}
/* push和pop都会调用 */
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        HYNavTransition *tansition = [HYNavTransition new];
        return tansition;
    } else if(operation == UINavigationControllerOperationPop) {
        HYNavPopTransition *tansition = [HYNavPopTransition new];
        return tansition;
    }
    return nil;
}



@end
