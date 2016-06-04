//
//  AddrInfo.h
//  GetAddrInfoOSX
//
//  Created by Jon Hoffman
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddrInfo : NSObject

@property (nonatomic, strong) NSString *hostname, *service;
@property (nonatomic) struct addrinfo *results;
@property (nonatomic) struct sockaddr *sa;
@property (nonatomic, readonly) int errorCode;

-(void)addrWithHostname:(NSString*)lHostname Service:(NSString *)lService andHints:(struct addrinfo*)lHints;
-(void)nameWithSockaddr:(struct sockaddr *)saddr;

-(NSString *)errorString;

@end
