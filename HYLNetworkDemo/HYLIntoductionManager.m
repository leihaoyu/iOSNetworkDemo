//
//  HYLIntoductionManager.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/3.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLIntoductionManager.h"

@implementation HYLIntoductionManager

{
    NSDictionary *_introDic;
}

+ (instancetype)sharedManager
{
    static id _sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Introductions" ofType:@"plist"];
        
        if ([fileManager fileExistsAtPath:filePath]) {
            _introDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
            
        }
    }
    return self;
}

- (NSString *)introductionWithKey:(NSString *)key
{
    NSString *str = [_introDic objectForKey:key];
    if (str) {
        return str;
    } else {
        return @"NO_DATA";
    }
}

@end
