//
//  NSArray+Util.h
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Util)

/**
 Return an object at a given index, or nil if there isn't an object at the index.
 */
- (id) safeObjectAtIndex:(NSUInteger) inIndex;

@end
