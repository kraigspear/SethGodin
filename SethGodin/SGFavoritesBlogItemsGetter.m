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
#import "SGNotifications.h"
#import "SGUSerDefaults.h"
#import "SGFavoritesCoreData.h"

@implementation SGFavoritesBlogItemsGetter
{
@private
    
}

- (void) requestItemssuccess:(SWArrayBlock) inSuccess failed:(SWErrorBlock) inError
{
    inSuccess(self.cachedItems);
}


- (NSArray*) cachedItems
{
    NSArray *favorites = [SGFavoritesCoreData allFavorites];
    [self updateShareCountsForEntries:favorites];
    return favorites;
}

@end
