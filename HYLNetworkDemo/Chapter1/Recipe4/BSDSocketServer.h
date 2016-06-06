//
//  BSDSocketServer.h
//  DatTimeTcpSvriOS
//
//  Created by Jon Hoffman on 4/9/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LISTENQ 1024
#define MAXLINE 4096

typedef NS_ENUM(NSUInteger, BSDServerErrorCode) {
    NOERROR,
    SOCKETERROR,
    BINDERROR,
    LISTENERROR,
    ACCEPTINGERROR
};

@interface BSDSocketServer : NSObject

@property (nonatomic) int errorCode, listenfd;

-(id)initOnPort:(int)port;
-(void)echoServerListenWithDescriptor:(int)lfd;
-(void)dataServerListenWithDescriptor:(int)lfd;

@end
