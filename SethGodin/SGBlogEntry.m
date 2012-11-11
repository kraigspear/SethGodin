//
//  SGBlogEntry.m
//  SethGodin
//
//  Created by Kraig Spear on 11/10/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogEntry.h"

@implementation SGBlogEntry

- (id) initWithDisplayName:(NSString*) inDisplayName
               publishedOn:(NSDate*) inDate
                   summary:(NSString*) inSummary
                   content:(NSString*) inContent
                    itemID:(NSString *)inID
                    fromURL:(NSString*) inUrlStr;
{
    self = [super init];
    
    _displayName   = inDisplayName;
    _datePublished = inDate;
    _summary       = inSummary;
    _content       = inContent;
    _itemID        = inID;
    _urlStr        = inUrlStr;
    
    return self;
}

- (NSString*) description
{
    return self.displayName;
}

- (BOOL) isEqual:(id) other
{
	if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToWidget:other];
}

- (BOOL)isEqualToWidget:(SGBlogEntry *) wp
{
    if (self == wp)
        return YES;
	
    return [self.itemID isEqualToString:wp.itemID];
}

@end
