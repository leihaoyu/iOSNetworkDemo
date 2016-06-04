//
//  AddrInfo.m
//  GetAddrInfoOSX
//
//  Created by Jon Hoffman
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import "AddrInfo.h"
#import <netdb.h>
#import <netinet/in.h>
#import <netinet6/in6.h>

@implementation AddrInfo

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setVars];
    }
    return self;
}

-(void)addrWithHostname:(NSString*)lHostname Service:(NSString *)lService andHints:(struct addrinfo*)lHints {
    
    [self setVars];
    self.hostname = lHostname;
    self.service = lService;
    
    struct addrinfo *res;
    
    _errorCode = getaddrinfo([self.hostname UTF8String], [self.service UTF8String], lHints, &res);
    self.results = res;
    
}

-(void)nameWithSockaddr:(struct sockaddr *)saddr {
    
    [self setVars];
    char host[1024];
    char serv[20];
    
    _errorCode = getnameinfo(saddr, sizeof saddr, host, sizeof host, serv, sizeof serv, 0);
    
    self.hostname = [NSString stringWithUTF8String:host];
    self.service = [NSString stringWithUTF8String:serv];
    
}

-(void)setVars {
    self.hostname = @"";
    self.service = @"";
    self.results = NULL;
    _errorCode = 0;
}



-(NSString *)errorString {
    return [NSString stringWithCString:gai_strerror(_errorCode) encoding:NSASCIIStringEncoding];
}


-(void)setResults:(struct addrinfo *)lResults {
    freeaddrinfo(self.results);
    _results = lResults;
}





@end
