//
//  HYNavOneViewController.h
//  自定义跳转
//
//  Created by 华惠友 on 2018/5/31.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYNavOneViewController : UIViewController

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (assign, nonatomic) CGRect finiRect;
@end
