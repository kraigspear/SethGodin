//
//  SGConentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogItemsGetter.h"



@implementation SGBlogItemsGetter
{
@private
    NSDateFormatter *_dateFormatter;
}

- (id) init
{
    self = [super init];
    
    if(self)
    {
        NSLocale *enUS = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = enUS;
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    return self;
    
}

- (void) requestItemssuccess:(BlogContentSuccess) inSuccess failed:(BlogContentFailed) inError
{
    
}

- (NSDate*) dateFromString:(NSString*) inDateStr
{
    NSString *dateStr      = [inDateStr substringToIndex:10];
    NSDate *dateFromFormat = [_dateFormatter dateFromString:dateStr];
    return dateFromFormat;
}

@end
