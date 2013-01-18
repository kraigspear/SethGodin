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
#import "SGFavoritesParse.h"

@implementation SGFavoritesBlogItemsGetter
{
@private
    
}

- (void) requestItemssuccess:(SWArrayBlock) inSuccess failed:(SWErrorBlock) inError
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSArray *items = [self cachedItems];
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                       {
                           inSuccess(items);
                       });
                   });
                   
}


- (NSArray*) cachedItems
{
    NSArray *favorites = [SGFavoritesParse allFavorites];
    [self updateShareCountsForEntries:favorites];
    return favorites;
}

@end
