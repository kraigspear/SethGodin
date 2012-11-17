//
//  NSDate+General.h
//  SethGodin
//
//  Created by Kraig Spear on 11/15/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Generic date functions that don't apply to a specifc task.
 */
@interface NSDate (General)

/**
 The year value for this date
 @return Year for this date
 */
- (NSUInteger) year;

/**
 Month value for this date
 @return The month for this date
 */
- (NSUInteger) month;

@end
