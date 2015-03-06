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
/**
 Array of SGBlogEntrys marked as favorites.
 */
@property (nonatomic, strong) NSArray *favorites;


+ (BOOL) favoritesFileExist;
+ (void) deleteFavoritesFile;

@end
