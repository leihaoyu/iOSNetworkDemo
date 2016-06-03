//
//  ByteOrder.m
//  ByteOrder
//
//  Created by Jon Hoffman on 3/30/13.
//  Copyright (c) 2013 Jon Hoffman. All rights reserved.
//

#import "ByteOrder.h"

@implementation ByteOrder

-(EndianType)byteOrder {
    union {
        short sNum;
        char cNum[sizeof(short)];
    } un;
    
    un.sNum = 0x0102;
    
    if (sizeof(short) == 2) {
        if(un.cNum[0] == 1 && un.cNum[1] == 2)
            return ENDIAN_BIG;
        else if (un.cNum[0] == 2 && un.cNum[1] == 1)
            return ENDIAN_LITTLE;
        else
            return ENDIAN_UNKNOWN;
    } else
        return ENDIAN_UNKNOWN;
}

@end
