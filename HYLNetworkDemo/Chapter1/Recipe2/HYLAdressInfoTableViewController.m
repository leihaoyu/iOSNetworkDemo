//
//  HYLAdressInfoTableViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLAdressInfoTableViewController.h"
#import "NetworkAddressInformation.h"
#import "HYLAddrInfoTableViewCell.h"

@interface HYLAdressInfoTableViewController ()
@property (nonatomic, strong) NetworkAddressInformation *netAddrInfo;
@end

@implementation HYLAdressInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.netAddrInfo = [[NetworkAddressInformation alloc] init];
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.netAddrInfo.networkAddresses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NetworkAddressStore *ns = self.netAddrInfo.networkAddresses[indexPath.row];
    if ([cell isKindOfClass:[HYLAddrInfoTableViewCell class]]) {
        ((HYLAddrInfoTableViewCell *)cell).interfaceLabel.text = ns.interface;
        ((HYLAddrInfoTableViewCell *)cell).addrLabel.text = ns.address;
        ((HYLAddrInfoTableViewCell *)cell).versionLabel.text = [ns getAddressVersionString];
        ((HYLAddrInfoTableViewCell *)cell).networkLabel.text = ns.netmask;
        ((HYLAddrInfoTableViewCell *)cell).gatewayLabel.text = ns.gateway;
    }
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
