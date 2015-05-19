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

/**
 Is this day today?
 @return Yes if today
 */
- (BOOL) isToday;

/**
 Is this date the same day as anotherDate
 @param anotherDate The day to compare to.
 @return Yes if the same day as antoherDate
 */
- (BOOL)isSameDayAs:(NSDate*)anotherDate;

/**
 Number of minutes since now
 */
- (NSInteger) numberOfMinutesSince;

/**
 *  Number of minutes since another date
 *
 *  @param otherDate Other date to subtract from
 *
 *  @return The number of hours since the other date
 */
- (NSInteger) numberOfHoursSince:(NSDate*) otherDate;

/**
 *  The number of hours since the current date
 *
 *  @return Number of hours since the date
 */
- (NSInteger) numberOfHoursSince;

/**
 Number of minutes since a date.
 */
- (NSInteger) numberOfMinutesSince:(NSDate*) otherDate;

@end
