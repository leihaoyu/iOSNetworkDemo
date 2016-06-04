//
//  HYLResolutionAddrViewController.m
//  HYLNetworkDemo
//
//  Created by zjr2015 on 16/6/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HYLResolutionAddrViewController.h"
#import "AddrInfo.h"
#import <netdb.h>
#import <arpa/inet.h>

@interface HYLResolutionAddrViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UITextField *serviceTF;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*addressArray;
@end

@implementation HYLResolutionAddrViewController

- (void)setAddressArray:(NSArray<NSDictionary *> *)addressArray {
    _addressArray = addressArray;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)startResolute:(id)sender {
    struct addrinfo *res;
    struct addrinfo hints;
    
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;   // Any Address Version, could set to AF_INET or AF_INET6 if we wanted to limit the IP version
    hints.ai_socktype = SOCK_STREAM;  //  Limit our search to Socket Stream, se could also set this to SOCK_DGRAM
    
    //Get address information given a hostname and service name.
    AddrInfo *ai = [[AddrInfo alloc] init];
    [ai addrWithHostname:self.inputTF.text Service:self.serviceTF.text andHints:&hints];
    
    if (ai.errorCode != 0) {
        NSLog(@"Error in getaddrinfo():  %@",[ai errorString]);
        return ;
    }
    
    //Get results and loop through them.
    NSMutableArray *muarr = [NSMutableArray array];
    struct addrinfo *results = ai.results;
    for (res = results; res!= NULL; res = res->ai_next) {
        void *addr;
        NSString *ipver = @"";
        char ipstr[INET6_ADDRSTRLEN];
        
        
        if (res->ai_family == AF_INET) {
            struct sockaddr_in *ipv4 = (struct sockaddr_in *)res->ai_addr;
            addr = &(ipv4->sin_addr);
            ipver = @"IPv4";
        } else if (res->ai_family == AF_INET6){
            struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)res->ai_addr;
            addr = &(ipv6->sin6_addr);
            ipver = @"IPv6";
        } else {
            continue;
        }
        
        //Show results
        inet_ntop(res->ai_family, addr, ipstr,sizeof ipstr);
        NSLog(@"     %@  %s", ipver, ipstr);
        
        //Convert sockaddr back to host/service names
        AddrInfo *ai2 = [[AddrInfo alloc] init];
        [ai2 nameWithSockaddr:res->ai_addr];
        if (ai2.errorCode ==0) {
            NSLog(@"--%@ %@",ai2.hostname, ai2.service);
            [muarr addObject:@{@"name": ai2.hostname, @"service": ai2.service}];
        }
    }
    self.addressArray = [muarr copy];
    freeaddrinfo(results);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.addressArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.addressArray[indexPath.row][@"name"];
    cell.detailTextLabel.text = self.addressArray[indexPath.row][@"service"];
    return cell;
}

@end
