//
//  HYLDataServerCollectionViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLDataServerCollectionViewController.h"
#import "HYLDataServerCollectionViewCell.h"
#import "BSDSocketServer.h"

@interface HYLDataServerCollectionViewController ()
@property (nonatomic, strong) NSArray *imagesPaths;
@end

@implementation HYLDataServerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static  NSString * const FileName = @"ImageArray.plist";

- (NSString *)applicationDocumentDirectoryFile
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:FileName];
    return path;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesPaths = [NSMutableArray arrayWithContentsOfFile:[self applicationDocumentDirectoryFile]];
    
    
//    [self.collectionView registerClass:[HYLDataServerCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    
}

- (IBAction)satrtServer:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BSDSocketServer *bsdServ = [[BSDSocketServer alloc] initOnPort:2006];
        if (bsdServ.errorCode == NOERROR) {
            NSLog(@"成功开启 ");
            [bsdServ dataServerListenWithDescriptor:bsdServ.listenfd];
            
        } else {
            NSLog(@"%@",[NSString stringWithFormat:@"Error code %d recieved.  Server was not started", bsdServ.errorCode]);
        }
    });
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imagesPaths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYLDataServerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *path = self.imagesPaths[indexPath.row];
    NSLog(@"%@", path);
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    cell.imageView.image = image;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
