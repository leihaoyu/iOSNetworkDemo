//
//  BSDSocketClient.h
//  EchoTcpClient2
//
//  Created by Jon Hoffman on 4/12/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BSDClientErrorCode) {
    NOERRROR,
    SOCKETERROR,
    CONNECTERROR,
    READERROR,
    WRITEERROR
};

#define MAXLINE 4096

@interface BSDSocketClient : NSObject

@property int errorCode, sockfd;

-(instancetype)initWithAddress:(NSString *)addr andPort:(int)port;
-(ssize_t) writtenToSocket:(int)sockfdNum withChar:(NSString *)vptr;
-(NSString *) recvFromSocket:(int)lsockfd withMaxChar:(int)max;

-(ssize_t)sendData:(NSData *)data toSocket:(int)lsockfd;
@end
