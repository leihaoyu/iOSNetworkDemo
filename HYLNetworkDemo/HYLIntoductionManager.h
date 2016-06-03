//
//  HYLIntoductionManager.h
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/3.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYLIntoductionManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)introductionWithKey:(NSString *)key;
@end
