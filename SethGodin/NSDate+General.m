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
    unsigned unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return comps.year;
}

- (NSUInteger) month
{
    NSCalendar *calendar = [NSDate currentCalendar];
    unsigned unitFlags = NSMonthCalendarUnit;
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
    
	NSDateComponents* components1 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
	NSDateComponents* components2 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:anotherDate];
    
    if(components1.month != components2.month) return NO;
    if(components1.day   != components2.day)     return NO;
    if(components1.year  != components2.year)   return NO;
    
    return YES;
}

@end
