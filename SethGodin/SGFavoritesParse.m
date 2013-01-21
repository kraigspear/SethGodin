//
//  SGFavoritesParse.m
//  SethGodin
//
//  Created by Kraig Spear on 1/18/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGFavoritesParse.h"
#import "SGFavorites.h"
#import <Parse/Parse.h>

NSString * const PARSE_CLASS_FAVORITE   = @"Favorite";
NSString * const PARSE_COL_CURRENT_USER = @"currentUser";
NSString * const PARSE_COL_DATE_PUBLISHED = @"datePublished";
NSString * const PARSE_COL_CONTENT        = @"content";
NSString * const PARSE_COL_TITLE          = @"title";
NSString * const PARSE_COL_FAVORITE_ID    = @"favoriteID";
NSString * const PARSE_COL_SUMMARY        = @"summary";
NSString * const PARSE_COL_URL            = @"url";


@implementation SGFavoritesParse

+ (void) addBlogEntryToFavorites:(SGBlogEntry*) inEntry
{
    PFObject *favorite = [PFObject objectWithClassName:PARSE_CLASS_FAVORITE];
    
    [favorite setObject:inEntry.content forKey:PARSE_COL_CONTENT];
    [favorite setObject:inEntry.datePublished forKey:PARSE_COL_DATE_PUBLISHED];
    [favorite setObject:inEntry.title forKey:PARSE_COL_TITLE];
    [favorite setObject:inEntry.itemID forKey:PARSE_COL_FAVORITE_ID];
    [favorite setObject:inEntry.summary forKey:PARSE_COL_SUMMARY];
    [favorite setObject:inEntry.urlStr forKey:PARSE_COL_URL];
    [favorite setObject:[PFUser currentUser] forKey:PARSE_COL_CURRENT_USER];
    
    [favorite saveEventually];
}

+ (PFQuery*) queryForBlogEntry:(SGBlogEntry*) inEntry
{
    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_FAVORITE];
    [query whereKey:@"favoriteID" equalTo:inEntry.itemID];
    [query whereKey:PARSE_COL_CURRENT_USER equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    return query;
}

+ (void) toggleBlogEntryAsAFavorite:(SGBlogEntry*) inEntry
{
    PFQuery *query = [SGFavoritesParse queryForBlogEntry:inEntry];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         NSLog(@"parse error %@", error.localizedDescription);
         
         if(object)
         {
             [object deleteEventually];
         }
         else
         {
             [SGFavoritesParse addBlogEntryToFavorites:inEntry];
         }
         
     }];
}

+ (void) removeBlogEntryFromFavorites:(SGBlogEntry*) inEntry
{
    PFQuery *query = [SGFavoritesParse queryForBlogEntry:inEntry];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
    {
        if(error)
        {
            [Flurry logError:@"FindObjectError" message:@"Couldn't find favorite to delete" error:error];
        }
        else
        {
            [object deleteEventually];
        }
    }];
}

+ (void) isBlogItemFavorite:(SGBlogEntry*) inBlogEntry success:(SWBoolBlock) inSuccess
{
    PFQuery *query = [SGFavoritesParse queryForBlogEntry:inBlogEntry];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error)
    {
        inSuccess(number > 0);
    }];
    
}

+ (NSArray*) allFavorites
{
    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_FAVORITE];
    
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [query whereKey:PARSE_COL_CURRENT_USER equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    
    NSError *error;
    NSArray *objects = [query findObjects:&error];
    
    if(error)
    {
        [Flurry logError:@"allFavoritesError" message:@"Couldn't get favorites" error:error];
        return @[];
    }
    else
    {
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:objects.count];
        for(PFObject *obj in objects)
        {
            [items addObject:[SGFavoritesParse favoriteFromParseObject:obj]];
        }
        
        return items;
    }
    
}

+ (SGBlogEntry*) favoriteFromParseObject:(PFObject*) inObject
{
    
    SGBlogEntry *blogEntry = [[SGBlogEntry alloc]
       initWithTitle:[inObject objectForKey:PARSE_COL_TITLE]
       publishedOn:[inObject  objectForKey:PARSE_COL_DATE_PUBLISHED]
                              summary:[inObject objectForKey:PARSE_COL_SUMMARY]
                              content:[inObject objectForKey:PARSE_COL_CONTENT]
                              itemID:[inObject objectForKey:PARSE_COL_FAVORITE_ID]
                              fromURL:[inObject objectForKey:PARSE_COL_URL]];
    
    
    return blogEntry;
}

+ (void) moveUserDataToCurrentUserFor:(PFUser*) oldUser
{

    const NSUInteger batchSize = 100;

    PFUser *currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_FAVORITE];
    [query whereKey:PARSE_COL_CURRENT_USER equalTo:oldUser];
    query.limit = batchSize;
    NSError *error;
    NSArray *favorites;
    
    do
    {
        favorites = [query findObjects:&error];
        
        if(!error)
        {
            for(PFObject *oldFav in favorites)
            {
                [oldFav setObject:currentUser forKey:PARSE_COL_CURRENT_USER];
                
                NSError *saveError;
                if(![oldFav save:&saveError])
                {
                    NSLog(@"not able to save favorite %@", saveError.localizedDescription);
                }
            }
        }
        
    } while (error == nil && favorites.count == batchSize);
    
    
}

@end
