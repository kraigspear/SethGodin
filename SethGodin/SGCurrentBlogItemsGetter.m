//
//  SGBlogContentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/10/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGCurrentBlogItemsGetter.h"
#import "SGBlogEntry.h"
#import "AFNetworking.h"
#import "NSDate+General.h"



//http://profile.typepad.com/sethgodin/activity.json

@implementation SGCurrentBlogItemsGetter
{
@private
    NSDate *_lastLoadedDate;
}

- (void) requestItemssuccess:(SWArrayBlock) inSuccess failed:(SWErrorBlock) inError
{
    NSArray *cacheItems = self.cachedItems;
    
    if(cacheItems)
    {
        if(cacheItems.count > 0)
        {
            [self updateShareCountsForEntries:cacheItems];
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               inSuccess(cacheItems);
                           });
        }
    }
    
    NSURL *url = [NSURL URLWithString:@"http://profile.typepad.com/sethgodin/activity.json"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSArray *items = [self itemsFromDictionary:responseObject];
             
             self.cachedItems = items;
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                _lastLoadedDate = [NSDate date];
                                inSuccess(items);
                            });
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             inError(error);
         }];
    
}

- (NSArray*) itemsFromDictionary:(NSDictionary*) inDictionary
{
    NSArray *items = [inDictionary objectForKey:@"items"];
    
    NSMutableArray *blogEntires = [NSMutableArray arrayWithCapacity:items.count];
    
    for(NSDictionary *itemDict in items)
    {
        NSString *dateStr = [[itemDict objectForKey:@"published"] substringToIndex:10];
        NSDate *datePublished = [self dateFromString:dateStr];
        
        NSDictionary *objDict = [itemDict objectForKey:@"object"];
        NSString *summary = [objDict objectForKey:@"summary"];
        NSString *content = [objDict objectForKey:@"content"];
        NSString *displayName = [objDict objectForKey:@"displayName"];
        NSString *itemID      = [objDict objectForKey:@"id"];
        NSString *urlStr      = [objDict objectForKey:@"url"];

        SGBlogEntry *blogEntry = [[SGBlogEntry alloc] initWithTitle:displayName
                                                              publishedOn:datePublished
                                                              summary:summary
                                                              content:content
                                                              itemID:itemID
                                                              fromURL:urlStr];
        
        
        [self updateShareCountForBlogEntry:blogEntry];
        [blogEntires addObject:blogEntry];
    }
    
    return blogEntires;
}

#pragma mark -
#pragma mark caching


- (NSString*) cacheKey
{
    return @"currentBlogItems";
}


@end
