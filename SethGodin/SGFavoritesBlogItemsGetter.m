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

- (void)main
{
  self.executing = YES;
  self.blogEntries = [SGFavoritesParse allFavorites];
  self.finished = YES;
  self.executing = NO;
}


- (NSArray*) cachedItems
{
    NSArray *favorites = [SGFavoritesParse allFavorites];
    [self updateShareCountsForEntries:favorites];
    return favorites;
}

@end
