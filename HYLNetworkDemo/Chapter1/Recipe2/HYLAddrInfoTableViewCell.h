//
//  HYLAddrInfoTableViewCell.h
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYLAddrInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *interfaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *networkLabel;
@property (weak, nonatomic) IBOutlet UILabel *gatewayLabel;

@end
