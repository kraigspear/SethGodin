//
//  NSArray+Util.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "NSArray+Util.h"

@implementation NSArray (Util)

- (id) safeObjectAtIndex:(NSUInteger) inIndex
{
    if(inIndex <= (self.count - 1))
    {
        return [self objectAtIndex:inIndex];
    }
    else
    {
        return nil;
    }
}

@end
