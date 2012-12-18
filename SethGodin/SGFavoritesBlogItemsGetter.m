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
#import "SGFavoritesLoader.h"
#import "SGNotifications.h"
#import "SGFavoritesDocument.h"

@implementation SGFavoritesBlogItemsGetter
{
@private

}

- (void) requestItemssuccess:(ArrayBlock) inSuccess failed:(ErrorBlock) inError
{
    
    SGFavorites *favorites = [SGFavoritesLoader sharedInstance].favoritesDoc.cloudData;
    
    for(SGBlogEntry *blogEntry in favorites.favorites)
    {
        [self updateShareCountForBlogEntry:blogEntry];
    }

    inSuccess(favorites.favorites);
}


- (NSArray*) cachedItems
{
    return [SGFavoritesLoader sharedInstance].favoritesDoc.cloudData.favorites;
}

@end
