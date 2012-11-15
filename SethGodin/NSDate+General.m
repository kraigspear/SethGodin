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

@end
