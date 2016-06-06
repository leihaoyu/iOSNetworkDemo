//
//  HYLEchoClientViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLEchoClientViewController.h"
#import "BSDSocketClient.h"

@interface HYLEchoClientViewController ()
@property (weak, nonatomic) IBOutlet UITextField *portTf;
@property (weak, nonatomic) IBOutlet UITextField *msgTF;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) BSDSocketClient *bsdCli;

@end

@implementation HYLEchoClientViewController


- (IBAction)connectBtn:(id)sender {
    self.bsdCli = [[BSDSocketClient alloc] initWithAddress:@"127.0.0.1" andPort:self.portTf.text.intValue];
    if (self.bsdCli.errorCode == NOERRROR) {
        self.resultLabel.text = @"连接成功";
        
    } else {
        self.resultLabel.text = [NSString stringWithFormat:@"Error code %d recieved.  Server was not started", self.bsdCli.errorCode];
        NSLog(@"%@",[NSString stringWithFormat:@"Error code %d recieved.  Server was not started", self.bsdCli.errorCode]);
    }

}
- (IBAction)send:(id)sender {
    if (self.bsdCli.errorCode == NOERRROR) {
        [self.bsdCli writtenToSocket:self.bsdCli.sockfd withChar:self.msgTF.text];
        
        NSString *recv = [self.bsdCli recvFromSocket:self.bsdCli.sockfd withMaxChar:MAXLINE];
        self.resultLabel.text = recv;
        self.msgTF.text = @"";
        
    } else {
        NSLog(@"%@",[NSString stringWithFormat:@"Error code %d recieved.  Server was not started", self.bsdCli.errorCode]);
    }

}



@end
