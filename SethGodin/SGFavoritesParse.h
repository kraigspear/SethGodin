//
//  SGFavoritesParse.h
//  SethGodin
//
//  Created by Kraig Spear on 1/18/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGBlogEntry.h"
#import "BlockTypes.h"

@interface SGFavoritesParse : NSObject

+ (void) addBlogEntryToFavorites:(SGBlogEntry*) inEntry;
+ (void) removeBlogEntryFromFavorites:(SGBlogEntry*) inEntry;
+ (NSArray*) allFavorites;
+ (void) toggleBlogEntryAsAFavorite:(SGBlogEntry*) inEntry;
+ (void) isBlogItemFavorite:(SGBlogEntry*) inBlogEntry success:(SWBoolBlock) inSuccess;

@end
