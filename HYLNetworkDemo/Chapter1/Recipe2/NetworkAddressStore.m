//
//  NetworkAddressStore.m
//  AddrInfo
//
//  Created by Jon Hoffman on 3/31/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import "NetworkAddressStore.h"



@implementation NetworkAddressStore
@synthesize interface, address, gateway, netmask, addressVersion;

-(id)init {
    self.interface = @"Unknown Interface";
    self.address = @"Unknown Address";
    self.gateway = @"Unknown Gateway";
    self.netmask = @"Unknown Netmask";
    self.addressVersion = INETUNKNOWN;
    return self;
}

-(NSString *)getAddressVersionString {
    switch (self.addressVersion) {
        case INETUNKNOWN:
            return @"Unknown IP Version";
            break;
        case INET4:
            return @"IPv4";
            break;
        case INET6:
            return @"IPv6";
            break;
            
        default:
            return @"Unknown IP Version";
            break;
    }
}


@end
