//
//  SGFavoritesCoreData.h
//  SethGodin
//
//  Created by Kraig Spear on 1/3/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockTypes.h"

@class SGBlogEntry;

/**
 All database related task
 */
@interface SGFavoritesCoreData : NSObject

/**
 Gets an array of all Favorites
 */
+ (NSArray*) allFavorites;

/**
 Remove a favorite
 @param inEntry The favorite to remove
 */
+ (void) removeBlogEntryFromFavorites:(SGBlogEntry*) inEntry;

/**
 Add a blog entry to favorites
 @param inEntry The blog entry to add as a favorite
 */
+ (void) addBlogEntryToFavorites:(SGBlogEntry*) inEntry;

/**
 Toggle if a blog entry is a favorite or not.
 @param inEntry The blog entry to toggle YES or NO.
 */
+ (void) toggleBlogEntryAsAFavorite:(SGBlogEntry*) inEntry;

/**
 Find out if the Given BlogEntry is saved in favorites
 @param inBlogEntry The blog entry to look for
 @param inSuccess Block to call after the operation is complete
 */
+ (void) isBlogItemFavorite:(SGBlogEntry*) inBlogEntry success:(SWBoolBlock) inSuccess;

@end
