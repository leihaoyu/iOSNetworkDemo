//
//  ByteOrder.h
//  ByteOrder
//
//  Created by Jon Hoffman on 3/30/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EndianType) {
    ENDIAN_UNKNOWN,
    ENDIAN_LITTLE,
    ENDIAN_BIG
};

@interface ByteOrder : NSObject

-(EndianType)byteOrder;

@end
