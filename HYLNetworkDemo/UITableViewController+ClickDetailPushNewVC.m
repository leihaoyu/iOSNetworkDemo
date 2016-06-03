//
//  UITableViewController+ClickDetailPushNewVC.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/3.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "UITableViewController+ClickDetailPushNewVC.h"
#import "HYLDetailDisplayViewController.h"
#import "HYLIntoductionManager.h"

@implementation UITableViewController (ClickDetailPushNewVC)
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Detail"];
    if ([[vc class] isSubclassOfClass:[HYLDetailDisplayViewController class]]) {
        HYLDetailDisplayViewController *hylVc = (HYLDetailDisplayViewController *)vc;
        
        NSString *key = [NSString stringWithFormat:@"%@%ld", self.navigationItem.title, indexPath.row];
        NSString *introString = [[HYLIntoductionManager sharedManager] introductionWithKey:key];
        hylVc.displayString = introString;
        
        [self.navigationController pushViewController:hylVc animated:YES];
    }
}
@end
