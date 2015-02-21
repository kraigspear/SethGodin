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
#import "SGNotifications.h"

NSString * const PARSE_CLASS_FAVORITE     = @"Favorite";
NSString * const PARSE_COL_CURRENT_USER   = @"currentUser";
NSString * const PARSE_COL_DATE_PUBLISHED = @"datePublished";
NSString * const PARSE_COL_CONTENT        = @"content";
NSString * const PARSE_COL_TITLE          = @"title";
NSString * const PARSE_COL_FAVORITE_ID    = @"favoriteID";
NSString * const PARSE_COL_SUMMARY        = @"summary";
NSString * const PARSE_COL_URL            = @"url";

NSString * const PARSE_ARCHIVE_YEAR       = @"archiveYear";
NSString * const PARSE_ARCHIVE_MONTH      = @"archiveMonth";


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
    
    [favorite saveEventually:^(BOOL succeeded, NSError *error)
    {
        if(succeeded)
        {
            [SGNotifications postFavoriteAdded:inEntry];
        }
    }];
}

+ (PFQuery*) queryForBlogEntry:(SGBlogEntry*) inEntry
{
    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_FAVORITE];
    [query whereKey:@"favoriteID" equalTo:inEntry.itemID];
    [query whereKey:PARSE_COL_CURRENT_USER equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    return query;
}

+ (void) archiveLastYear:(NSNumber*) outYear andMonth:(NSNumber*) outMonth
{
    PFUser *user = [PFUser currentUser];
    outYear  = [user objectForKey:PARSE_ARCHIVE_YEAR];
    outMonth = [user objectForKey:PARSE_ARCHIVE_MONTH];
}

+ (void) updateUserLastArchiveSearchForMonth:(NSUInteger) inMonth year:(NSUInteger) year
{
    PFUser *user = [PFUser currentUser];
    [user setObject:@(inMonth) forKey:PARSE_ARCHIVE_MONTH];
    [user setObject:@(year)    forKey:PARSE_ARCHIVE_YEAR];
    [user saveEventually];
}

+ (void) toggleBlogEntryAsAFavorite:(SGBlogEntry*) inEntry
{
    PFQuery *query = [SGFavoritesParse queryForBlogEntry:inEntry];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         if(object)
         {
             [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
             {
                 if(succeeded)
                 {
                     [SGNotifications postFavoriteDeleted:inEntry];
                 }
             }];
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
        }
        else
        {
            [object deleteEventually];
        }
    }];
}

+ (void) isBlogItemFavorite:(SGBlogEntry*) inBlogEntry success:(SWBoolBlock) inSuccess
{
    if(![PFUser currentUser])
    {
        inSuccess(NO);
        return;
    }
    
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
    NSDictionary *params = @{@"oldUser" : oldUser.objectId};
    
    [PFCloud callFunctionInBackground:@"moveUserDataToCurrentUserFor" withParameters:params block:^(id object, NSError *error)
    {
        
    }];
}

+ (void) exportFavoritesToParse
{
    if(![PFUser currentUser]) return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSLog(@"exporing to Parse");
                       NSArray *favoritesToExport = [[SGFavorites sharedInstance] favorites];
                       
                       if(favoritesToExport.count > 0)
                       {
                           for(SGBlogEntry *oldFavorite in favoritesToExport)
                           {
                               [SGFavoritesParse addBlogEntryToFavorites:oldFavorite];
                           }
                           
                           [SGFavorites deleteFavoritesFile];
                       }
                   });
}


@end
