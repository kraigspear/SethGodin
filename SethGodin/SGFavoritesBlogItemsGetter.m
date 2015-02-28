//
//  SGFavoritesContentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavoritesBlogItemsGetter.h"
#import "SGFavoritesParse.h"

@implementation SGFavoritesBlogItemsGetter
{
@private
    
}

- (BFTask*)requestItems
{
    BFTaskCompletionSource *source = [BFTaskCompletionSource taskCompletionSource];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSArray *items = [self cachedItems];
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [source setResult:items];
                       });
                   });

    return source.task;
}


- (NSArray*) cachedItems
{
    NSArray *favorites = [SGFavoritesParse allFavorites];
    [self updateShareCountsForEntries:favorites];
    return favorites;
}

@end
