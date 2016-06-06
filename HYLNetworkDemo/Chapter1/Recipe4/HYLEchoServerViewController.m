//
//  HYLEchoServerViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLEchoServerViewController.h"
#import "BSDSocketServer.h"

@interface HYLEchoServerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation HYLEchoServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickBeginBtn:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BSDSocketServer *bsdServ = [[BSDSocketServer alloc] initOnPort:self.portTF.text.intValue];
        if (bsdServ.errorCode == NOERROR) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.resultLabel.text = @"开启成功";
            });
            [bsdServ echoServerListenWithDescriptor:bsdServ.listenfd];
            
        } else {
            NSLog(@"%@", [NSString stringWithFormat:@"Error code %d recieved.  Server was not started", bsdServ.errorCode]);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.resultLabel.text = [NSString stringWithFormat:@"Error code %d recieved.  Server was not started", bsdServ.errorCode];
            });
        }
    });
    
}


@end
