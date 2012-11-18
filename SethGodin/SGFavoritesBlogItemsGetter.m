//
//  SGFavoritesContentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavoritesBlogItemsGetter.h"
#import "SGFavorites.h"
#import "SGBlogEntry.h"

@implementation SGFavoritesBlogItemsGetter

- (void) requestItemssuccess:(ArrayBlock) inSuccess failed:(ErrorBlock) inError
{
    SGFavorites *favorites = [SGFavorites loadFavorites];
    
    for(SGBlogEntry *blogEntry in favorites.favorites)
    {
        [self updateShareCountForBlogEntry:blogEntry];
    }
    
    inSuccess(favorites.favorites);
}

@end
