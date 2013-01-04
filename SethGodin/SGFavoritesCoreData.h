//
//  SGFavoritesCoreData.h
//  SethGodin
//
//  Created by Kraig Spear on 1/3/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
