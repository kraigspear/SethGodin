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



+ (void) addBlogEntryToFavorites:(SGBlogEntry*) inEntry
{
    [MagicalRecord saveInBackgroundWithBlock:^(NSManagedObjectContext *localContext)
    {
        Favorite *favorite = [Favorite MR_createInContext:localContext];
        favorite.content = inEntry.content;
        favorite.date = inEntry.datePublished;
        favorite.dateAdded = [NSDate date];
        favorite.title = inEntry.title;
        favorite.favoriteID = inEntry.itemID;
        favorite.summary = inEntry.summary;
        favorite.url = inEntry.urlStr;
    }];
}

+ (void) removeBlogEntryFromFavorites:(SGBlogEntry*) inEntry
{
    [MagicalRecord saveInBackgroundWithBlock:^(NSManagedObjectContext *localContext)
     {
         Favorite *favorite = [Favorite MR_findFirstByAttribute:@"favoriteID" withValue:inEntry.itemID inContext:localContext];
         
         [favorite MR_deleteInContext:localContext];
         
     }];
}

+ (void) toggleBlogEntryAsAFavorite:(SGBlogEntry*) inEntry
{
     [MagicalRecord saveInBackgroundWithBlock:^(NSManagedObjectContext *localContext)
     {
         Favorite *favorite = [Favorite MR_findFirstByAttribute:@"favoriteID" withValue:inEntry.itemID inContext:localContext];
         
         if(favorite)
         {
             [favorite MR_deleteInContext:localContext];
         }
         else
         {
             [SGFavoritesCoreData addBlogEntryToFavorites:inEntry];
         }
         
     }];
}

+ (void) isBlogItemFavorite:(SGBlogEntry*) inBlogEntry success:(SWBoolBlock) inSuccess
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favoriteID == %@", inBlogEntry.itemID];
        
        NSInteger count = [[Favorite MR_numberOfEntitiesWithPredicate:predicate] integerValue];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            inSuccess(count > 0);
        });
        
    });
}


@end
