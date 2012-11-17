//
//  SGConentGetter.h
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGBlogEntry;

typedef void (^BlogContentSuccess)(NSArray*);
typedef void (^BlogContentFailed)(NSError*);

/**
 Responsible for getting blog items.
 Parent for other classes that have the more specific logic of retrieving blog items.
 Example: Latest blog items, archive & favorites
 */
@interface SGBlogItemsGetter : NSObject


/**
 Feteches an array of blog items
 @param inSuccess block to receive the items
 @param inError if there was an error getting items
 */
- (void) requestItemssuccess:(BlogContentSuccess) inSuccess failed:(BlogContentFailed) inError;

/**
 Provides a date from a string that was supplited by typepad
 @return Date formatted from string
 @param inDateStr The string to convert to a date.
 */
- (NSDate*) dateFromString:(NSString*) inDateStr;

/**
 Updates the share count for a blog entry.
 @param inEntry The entry to update teh count for.
 */
- (void) updateShareCountForBlogEntry:(SGBlogEntry*) inEntry;

/**
 Turns JSON to SGBlogItems
 */
- (NSArray*) blockItemsForDictionary:(NSDictionary*) inDictionary;


@end
