//
//  SGBlogEntry.m
//  SethGodin
//
//  Created by Kraig Spear on 11/10/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogEntry.h"

@implementation SGBlogEntry

NSString * const KEY_DISPLAY_NAME = @"displayName";
NSString * const KEY_DATE         = @"date";
NSString * const KEY_SUMMARY      = @"summary";
NSString * const KEY_CONTENT      = @"content";
NSString * const KEY_ID           = @"id";
NSString * const KEY_URL          = @"url";


- (id) initWithTitle:(NSString*) inDisplayName
               publishedOn:(NSDate*) inDate
                   summary:(NSString*) inSummary
                   content:(NSString*) inContent
                    itemID:(NSString *)inID
                    fromURL:(NSString*) inUrlStr
{
    self = [super init];
    
    _title   = inDisplayName;
    _datePublished = inDate;
    _summary       = inSummary;
    _content       = inContent;
    _itemID        = inID;
    _urlStr        = inUrlStr;
    
    return self;
}

#pragma mark -
#pragma mark encoding

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    
    _title  = [aDecoder decodeObjectForKey:KEY_DISPLAY_NAME];
    _datePublished = [aDecoder decodeObjectForKey:KEY_DATE];
    _summary       = [aDecoder decodeObjectForKey:KEY_SUMMARY];
    _content       = [aDecoder decodeObjectForKey:KEY_CONTENT];
    _itemID        = [aDecoder decodeObjectForKey:KEY_ID];
    _urlStr        = [aDecoder decodeObjectForKey:KEY_URL];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:KEY_DISPLAY_NAME];
    [aCoder encodeObject:self.datePublished forKey:KEY_DATE];
    [aCoder encodeObject:self.summary forKey:KEY_SUMMARY];
    [aCoder encodeObject:self.content forKey:KEY_CONTENT];
    [aCoder encodeObject:self.itemID forKey:KEY_ID];
    [aCoder encodeObject:self.urlStr forKey:KEY_URL];
}


- (NSString*) description
{
    return self.title;
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
