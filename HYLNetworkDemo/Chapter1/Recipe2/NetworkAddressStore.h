//
//  NetworkAddressStore.h
//  AddrInfo
//
//  Created by Jon Hoffman on 3/31/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INETUNKNOWN 0
#define INET4 1
#define INET6 2

@interface NetworkAddressStore : NSObject

@property (strong, nonatomic) NSString *interface, *address, *netmask, *gateway;
@property int addressVersion;

-(NSString *)getAddressVersionString;

@end
