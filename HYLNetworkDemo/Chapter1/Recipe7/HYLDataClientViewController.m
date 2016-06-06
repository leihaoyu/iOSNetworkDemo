//
//  HYLDataClientViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLDataClientViewController.h"
#import "BSDSocketClient.h"

@interface HYLDataClientViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@end

@implementation HYLDataClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)clickUpload:(id)sender {
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self getImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self getImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


//获取图片
-(void)getImageWithSourceType:(UIImagePickerControllerSourceType)type{
    //先判断图片的来源可不可用
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        //若不可用则退出方法
        return;
    }
    
    //1.创建获取图片控制器
    UIImagePickerController *ipc=[[UIImagePickerController alloc]init];
    ipc.allowsEditing = YES;
    //2.选择图片获取来源（从本地照相机、本地相册等）
    ipc.sourceType=type;
    //3.设置代理方（选择图片后的处理）
    ipc.delegate=self;
    //4.推出图片的来源页面
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate 选择图片的响应方法
//从UIImagePickerController选择完图片后就调用（即照相完毕、在相册选择图片完毕）
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //NSLog(@"%@",info);
    /*
     UIImagePickerControllerOriginalImage = <UIImage: 0x7f9f79da1200> size {1500, 1001} orientation 0 scale 1.000000,
     UIImagePickerControllerMediaType = public.image,
     UIImagePickerControllerReferenceURL = assets-library://asset/asset.JPG?id=AF7BDDBC-7FB2-4AEF-84F0-65A0E5B9B9B3&ext=JPG
     */
    
    //info包含了选择的图片和相关信息
    
    //获取选择的图片
    UIImage *image=info[UIImagePickerControllerEditedImage];
    
    //上传头像到七牛和服务器
    [self uploadImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//上传头像到七牛
-(void)uploadImage:(UIImage *)image{
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    BSDSocketClient *bsdCli = [[BSDSocketClient alloc] initWithAddress:self.addressTF.text andPort:2006];
    if (bsdCli.errorCode == NOERRROR) {
        [bsdCli sendData:imageData toSocket:bsdCli.sockfd];
    } else {
        NSLog(@"%@",[NSString stringWithFormat:@"Error code %d recieved. ", bsdCli.errorCode]);
    }
    close(bsdCli.sockfd);
   
    
}



@end
