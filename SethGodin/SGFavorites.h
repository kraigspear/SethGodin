//
//  SGFavorites.h
//  SethGodin
//
//  Created by Kraig Spear on 11/13/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGBlogEntry;

@interface SGFavorites : NSObject <NSCoding>

+ (SGFavorites*) sharedInstance;
- (void) loadFavorites;
/**
 Array of SGBlogEntrys marked as favorites.
 */
@property (nonatomic, strong) NSArray *favorites;

/**
 Add a blog entry to favorites
 @param inEntry The entry to add
 */
- (void) addBlogEntry:(SGBlogEntry*) inEntry;

/**
 Remove a blog entry
 @param inEntry Blog entry to remove
 */
- (void) removeBlogEntry:(SGBlogEntry*) inEntry;

/**
 Checks if inEntry is a favorite
 @return Yes if favorite
 @param inEntry Item to check.
 */
- (BOOL) containsBlogEntry:(SGBlogEntry*) inEntry;

/**
 Yes if a saved favorite file exist.
 */
+ (BOOL) favoritesFileExist;

@end
