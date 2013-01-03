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

- (void) requestItemssuccess:(ArrayBlock) inSuccess failed:(ErrorBlock) inError
{
    
    
    
    inSuccess(self.cachedItems);
    
}


- (NSArray*) cachedItems
{
    return [SGFavoritesCoreData allFavorites];
}

@end
