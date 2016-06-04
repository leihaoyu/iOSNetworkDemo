//
//  NetworkAddressInformation.m
//  AddrInfo
//
//  Created by Jon Hoffman on 3/31/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import "NetworkAddressInformation.h"
#import <sys/types.h>
#import <sys/socket.h>
#import <netdb.h>
#import <arpa/inet.h>

#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation NetworkAddressInformation
@synthesize networkAddresses;

-(id)init {
    networkAddresses = [[NSMutableArray alloc] init];
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        for (temp_addr = interfaces; temp_addr != NULL; temp_addr = temp_addr->ifa_next) {
            NetworkAddressStore *ns = [[NetworkAddressStore alloc] init];
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                ns.addressVersion = INET4;
                char naddr[INET_ADDRSTRLEN];
                char nmask[INET_ADDRSTRLEN];
                char ngate[INET_ADDRSTRLEN];
                ns.interface = [NSString stringWithUTF8String:temp_addr->ifa_name];
                inet_ntop(AF_INET,&((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr,naddr,INET_ADDRSTRLEN);
                ns.address = [NSString stringWithUTF8String:naddr];
                inet_ntop(AF_INET,&((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr,nmask,INET_ADDRSTRLEN);
                ns.netmask = [NSString stringWithUTF8String:nmask];
                inet_ntop(AF_INET,&((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr,ngate,INET_ADDRSTRLEN);
                ns.gateway = [NSString stringWithUTF8String:ngate];
                
            } else if(temp_addr->ifa_addr->sa_family == AF_INET6) {
                ns.addressVersion = INET6;
                char naddr[INET6_ADDRSTRLEN];
                char ngate[INET6_ADDRSTRLEN];
                ns.interface = [NSString stringWithUTF8String:temp_addr->ifa_name];
                inet_ntop(AF_INET6,&((struct sockaddr_in6 *)temp_addr->ifa_addr)->sin6_addr,naddr,INET6_ADDRSTRLEN);
                ns.address = [NSString stringWithUTF8String:naddr];
                ns.netmask = @"";
                if ((struct sockaddr_in6 *)temp_addr->ifa_dstaddr != NULL) {
                    inet_ntop(AF_INET6,&((struct sockaddr_in6 *)temp_addr->ifa_dstaddr)->sin6_addr,ngate,INET6_ADDRSTRLEN);
                    ns.gateway = [NSString stringWithUTF8String:ngate];
                } else
                    ns.gateway = @" ";
                
            }else {
                continue;
            }
        [networkAddresses addObject:ns];
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    
    
    return self;
}



@end
