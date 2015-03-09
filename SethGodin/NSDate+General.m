//
//  NSDate+General.m
//  SethGodin
//
//  Created by Kraig Spear on 11/15/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "NSDate+General.h"

@implementation NSDate (General)

static NSCalendar *_calendar;

+ (NSCalendar*) currentCalendar
{
    if(!_calendar) _calendar = [NSCalendar currentCalendar];
    return _calendar;
}

- (NSUInteger) year
{
    NSCalendar *calendar = [NSDate currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return comps.year;
}

- (NSUInteger) month
{
    NSCalendar *calendar = [NSDate currentCalendar];
    unsigned unitFlags = NSCalendarUnitMonth;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return comps.month;
}

- (BOOL) isToday
{
	return [self isSameDayAs:[NSDate date]];
}

- (BOOL)isSameDayAs:(NSDate*)anotherDate
{
    NSCalendar *calendar = [NSDate currentCalendar];
    
	NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
	NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    
    if(components1.month != components2.month) return NO;
    if(components1.day   != components2.day)     return NO;
    if(components1.year  != components2.year)   return NO;
    
    return YES;
}

- (NSInteger) numberOfMinutesSince:(NSDate*) otherDate
{
	NSCalendar *sysCalendar = [NSDate currentCalendar];
	
	unsigned int unitFlags = NSCalendarUnitMinute | NSCalendarUnitSecond;
	
	NSLog(@"self = %@ otherDate = %@ calendar = %@", self, otherDate, sysCalendar);
	
	NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:self  toDate:otherDate options:0];
	
	return [breakdownInfo minute];
    
}

- (NSInteger) numberOfMinutesSince
{
    return [self numberOfMinutesSince:[NSDate date]];
}

@end
