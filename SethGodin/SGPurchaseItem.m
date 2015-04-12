//
//  SGPurchaseItem.m
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGPurchaseItem.h"

@implementation SGPurchaseItem


NSString * const KEY_TITLE             = @"title";
NSString * const KEY_RELEASED_ON       = @"releasedOn";
NSString * const KEY_TRACK_ID          = @"trackID";
NSString * const KEY_TRACK_IMAGE_URL   = @"imageURL";
NSString * const KEY_IMAGE             = @"image";

- (instancetype) initWithTitle:(NSString*) inTitle releasedOn:(NSDate*) inDate
                       trackId:(NSUInteger) inTrackId
{
    self = [self init];
    
    if(self)
    {
        _title        = [inTitle copy];
        _releasedDate = inDate;
        _trackID      = inTrackId;
    }
    
    return self;
}

#pragma mark -
#pragma mark equals / hash

- (NSUInteger) hash
{
	NSUInteger prime = 31;
	NSUInteger result = 1;
	
	result = prime * (result + _trackID);
	
	return result;
}

- (BOOL) isEqual:(id) other
{
	if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToWidget:other];
}

- (BOOL)isEqualToWidget:(SGPurchaseItem *) inItem
{
    if (self == inItem)
        return YES;
	
    return (self.trackID == inItem.trackID);
}


@end
