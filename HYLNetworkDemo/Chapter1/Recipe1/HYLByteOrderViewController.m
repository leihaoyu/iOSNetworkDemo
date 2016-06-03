//
//  HYLByteOrderViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/3.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLByteOrderViewController.h"
#import "ByteOrder.h"

@interface HYLByteOrderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation HYLByteOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickTestBtn:(id)sender {
    ByteOrder *bo = [[ByteOrder alloc] init];
    EndianType byteOrder = bo.byteOrder;
    
    switch (byteOrder) {
        case ENDIAN_BIG:
            self.resultLabel.text = @"大端";
            break;
        case ENDIAN_LITTLE:
            self.resultLabel.text = @"小端";
            break;
        case ENDIAN_UNKNOWN:
            self.resultLabel.text = @"未知";
            break;
            
        default:
            break;
    }

}

@end
