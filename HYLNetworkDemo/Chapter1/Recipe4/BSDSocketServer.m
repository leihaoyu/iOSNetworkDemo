//
//  BSDSocketServer.m
//  DatTimeTcpSvriOS
//
//  Created by Jon Hoffman on 4/9/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import "BSDSocketServer.h"
#import <sys/types.h>
#import <arpa/inet.h>

@implementation BSDSocketServer


-(id)initOnPort:(int)port {
    self = [super init];
    if (self) {
        struct sockaddr_in servaddr;
        
        self.errorCode = NOERROR;
        if ( (self.listenfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
            self.errorCode = SOCKETERROR;
        else {
            memset(&servaddr, 0, sizeof(servaddr));
            servaddr.sin_family = AF_INET;
            servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
            servaddr.sin_port = htons(port);
            
            if (bind(self.listenfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) <0) {
                self.errorCode = BINDERROR;
            } else {
                
                if ((listen (self.listenfd, LISTENQ)) <0) {
                    self.errorCode = LISTENERROR;
                }
            }
        }
    }
    return self;
}

-(void)echoServerListenWithDescriptor:(int)lfd {
    int connfd;
    socklen_t clilen;
    struct sockaddr_in cliaddr;
    char buf[MAXLINE];
    
    for (;;) {
        clilen = sizeof(cliaddr);
        if ((connfd = accept(lfd, (struct sockaddr *)&cliaddr, &clilen))<0) {
            if (errno != EINTR) {
                self.errorCode = ACCEPTINGERROR;
                NSLog(@"Error accepting connection");
            }
        } else {
            self.errorCode = NOERROR;
            NSString *connStr = [NSString stringWithFormat:@"Connection from %s, port %d", inet_ntop(AF_INET, &cliaddr.sin_addr,buf, sizeof(buf)),ntohs(cliaddr.sin_port)];
            NSLog(@"%@", connStr);
            
            //Multi-threaded
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [self strEchoServer:@(connfd)];
            });
            
        }
    }
}

//For Echo text
-(void)strEchoServer:(NSNumber *) sockfdNum {
    ssize_t n;
    char buf[MAXLINE];
    
    
    int sockfd = [sockfdNum intValue];
    while ((n=recv(sockfd, buf, MAXLINE -1,0)) > 0) {
        strcat(buf, "Hello I'm Server\n");
        
        [self written:sockfd char:buf size:strlen(buf)];
        buf[n]='\0';
        NSLog(@"%s",buf);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"posttext" object:[NSString stringWithCString:buf encoding:NSUTF8StringEncoding]];
        
    }
    NSLog(@"Closing Socket");
    close(sockfd);
}

-(ssize_t) written:(int)sockfdNum char:(const void *)vptr size:(size_t)n {
    
	size_t		nleft;
	ssize_t		nwritten;
	const char	*ptr;
    
	ptr = vptr;
	nleft = n;
	while (nleft > 0) {
		if ( (nwritten = write(sockfdNum, ptr, nleft)) <= 0) {
			if (nwritten < 0 && errno == EINTR)
				nwritten = 0;		/* and call write() again */
			else
				return(-1);			/* error */
		}
        
		nleft -= nwritten;
		ptr   += nwritten;
	}
	return(n);
}

-(void)dataServerListenWithDescriptor:(int)lfd {
    int connfd;
    socklen_t clilen;
    struct sockaddr_in cliaddr;
    char buf[MAXLINE];
    
    for (;;) {
        clilen = sizeof(cliaddr);
        if ((connfd = accept(lfd, (struct sockaddr *)&cliaddr, &clilen))<0) {
            if (errno != EINTR) {
                self.errorCode = ACCEPTINGERROR;
                NSLog(@"Error accepting connection");
            }
        } else {
            self.errorCode = NOERROR;
            NSString *connStr = [NSString stringWithFormat:@"Connection from %s, port %d", inet_ntop(AF_INET, &cliaddr.sin_addr,buf, sizeof(buf)),ntohs(cliaddr.sin_port)];
            NSLog(@"%@", connStr);
            
            //Multi-threaded
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [self getData:@(connfd)];
            });
            
        }
    }
}


-(void)getData:(NSNumber *) sockfdNum {
    
    ssize_t n;
    UInt8 buf[MAXLINE];
    NSMutableData *data = [[NSMutableData alloc] init];
    
    int sockfd = [sockfdNum intValue];
    while ((n=recv(sockfd, buf, MAXLINE -1,0)) > 0) {
        NSLog(@"Got %zd",n);
        [data appendBytes:buf length:n];
        NSLog(@"Data size %ld", (unsigned long)[data length]);
    }
    NSLog(@"Data Size 2 %ld", (unsigned long)[data length]);
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSMutableArray *images = [NSMutableArray arrayWithContentsOfFile:[self applicationDocumentDirectoryFile]];
    if (!images) {
        images = [NSMutableArray array];
    }
  
    NSString *appFile = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.png", images.count]];
    
    [data writeToFile:appFile atomically:YES];
    close(sockfd);
    NSLog(@"Done");
    
    
    [images addObject:appFile];
    [images writeToFile:[self applicationDocumentDirectoryFile] atomically:YES];
    
}


- (NSString *)applicationDocumentDirectoryFile
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:FileName];
    return path;
}


static  NSString * const FileName = @"ImageArray.plist";
@end
