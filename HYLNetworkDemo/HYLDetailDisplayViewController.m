//
//  HYLDetailDisplayViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/3.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLDetailDisplayViewController.h"

@interface HYLDetailDisplayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation HYLDetailDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentLabel.text = self.displayString;
}


@end
