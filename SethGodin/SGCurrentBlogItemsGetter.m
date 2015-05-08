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

@implementation SGCurrentBlogItemsGetter

- (void)main
{
  @weakify(self);
  
  self.executing = YES;
  
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
                          @strongify(self);
                          self.blogEntries = items;
                          [self done];
                        });
         
       }
       failure:^(NSURLSessionDataTask *task, NSError *error)
   {
     dispatch_async(dispatch_get_main_queue(), ^
                    {
                      self.error = error;
                      [self done];
                    });
   }];
}

- (NSArray*) itemsFromDictionary:(NSDictionary*) inDictionary
{
  NSArray *items = inDictionary[@"items"];
  
  NSMutableArray *blogEntries = [NSMutableArray arrayWithCapacity:items.count];
  
  for(NSDictionary *itemDict in items)
  {
    NSString *dateStr = [itemDict[@"published"] substringToIndex:10];
    NSDate *datePublished = [self dateFromString:dateStr];
    
    NSDictionary *objDict = itemDict[@"object"];
    NSString *summary = objDict[@"summary"];
    NSString *content = objDict[@"content"];
    NSString *displayName = objDict[@"displayName"];
    NSString *itemID      = objDict[@"id"];
    NSString *urlStr      = objDict[@"url"];
    
    SGBlogEntry *blogEntry = [[SGBlogEntry alloc] initWithTitle:displayName
                                                    publishedOn:datePublished
                                                        summary:summary
                                                        content:content
                                                         itemID:itemID
                                                        fromURL:urlStr];
    
    
    [self updateShareCountForBlogEntry:blogEntry];
    [blogEntries addObject:blogEntry];
  }
  
  
  
  
  return blogEntries;
}

#pragma mark -
#pragma mark caching


- (NSString*) cacheKey
{
  return @"currentBlogItems";
}


@end
