//
//  HYViewController.m
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/30.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYViewController.h"
#import "HYModelOneViewController.h"
#import "HYNavOneViewController.h"

@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (IBAction)btn1:(id)sender {
    HYModelOneViewController *vc = [[HYModelOneViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];

}
- (IBAction)btn2:(id)sender {
    HYNavOneViewController *vc = [HYNavOneViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
