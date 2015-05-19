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
{
@private
  BOOL _force;
}

- (instancetype) init
{
  self = [super init];
  
  if (self)
  {
    _force = NO;
  }
  
  return self;
}

- (instancetype) initWithForceRefresh:(BOOL) force
{
  self = [self init];
  
  if (self)
  {
    _force = force;
  }
  
  return self;
}

- (void)main
{
  self.executing = YES;
  
  //1.Determine if we need to load from the cache or network.
  //2.Load from the approbate place.
  if([AFNetworkReachabilityManager sharedManager].reachable)
  {
    if ( ([self ageOfCacheFileInHours] >= 24) || _force)
    {
      [self loadFromInternet];
    }
    else
    {
      [self loadFromCache];
    }
  }
  else
  {
    [self loadFromCache];
  }
}

- (void) loadFromInternet
{
  NSURL *url = [NSURL URLWithString:@"http://profile.typepad.com/sethgodin/activity.json"];
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  
  [manager GET:[url absoluteString]
    parameters:nil
       success:^(NSURLSessionDataTask *task, id responseObject)
   {
     
     NSArray *items = [self itemsFromDictionary:responseObject];
     self.cachedItems = items;
     self.blogEntries = items;
     [self done];
   }
   
   failure:^(NSURLSessionDataTask *task, NSError *error)
   {
     self.error = error;
     [self done];
   }];
}

- (void) loadFromCache
{
  self.blogEntries = self.cachedItems;
  
  [self updateShareCountsForEntries:self.blogEntries];
  
  [self done];
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
