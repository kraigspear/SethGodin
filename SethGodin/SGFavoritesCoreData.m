//
//  SGFavoritesCoreData.m
//  SethGodin
//
//  Created by Kraig Spear on 1/3/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGFavoritesCoreData.h"
#import "Favorite.h"
#import "SGBlogEntry.h"

@implementation SGFavoritesCoreData

+ (NSArray*) allFavorites
{
    NSArray *favorites = [Favorite MR_findAll];
    
    NSMutableArray *favReturn = [NSMutableArray arrayWithCapacity:favorites.count];
    
    for(Favorite *favorite in favorites)
    {
        NSString *title   = favorite.title;
        NSDate   *date    = favorite.date;
        NSString *summary = favorite.summary;
        NSString *idStr   = favorite.favoriteID;
        NSString *urlStr  = favorite.url;
        NSString *content = favorite.content;
        
        SGBlogEntry *blogEntry = [[SGBlogEntry alloc] initWithTitle:title publishedOn:date summary:summary content:content itemID:idStr fromURL:urlStr];
        
        [favReturn addObject:blogEntry];
    }
    
    return favReturn;
    
}


@end
