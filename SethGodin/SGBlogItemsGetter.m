//
//  SGConentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogItemsGetter.h"
#import "SGBlogEntry.h"
#import "SGNotifications.h"
#import "AFHTTPSessionManager.h"


NSString * const sharedContainerId = @"group.com.spearware.sethgodin";

@implementation SGBlogItemsGetter
{
@private
  NSDateFormatter *_dateFormatter;
}

#pragma mark -
#pragma mark general
- (id) init
{
  self = [super init];
  
  if(self)
  {
    NSLocale *enUS = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.locale = enUS;
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
  }
  
  return self;
  
}

- (NSDate*) dateFromString:(NSString*) inDateStr
{
  NSString *dateStr      = [inDateStr substringToIndex:10];
  NSDate *dateFromFormat = [_dateFormatter dateFromString:dateStr];
  return dateFromFormat;
}

#pragma mark -
#pragma mark share counts.

- (void) updateShareCountsForEntries:(NSArray*) inItems
{
  for(SGBlogEntry *entry in inItems)
  {
    [self updateShareCountForBlogEntry:entry];
  }
}

- (void) updateShareCountForBlogEntry:(SGBlogEntry*) inEntry
{
  [self updateFacebookCountForEntry:inEntry];
  [self updateTwitterCountForEntry:inEntry];
}

- (void) updateFacebookCountForEntry:(SGBlogEntry*) inEntry
{
  NSString *urlStr = [NSString stringWithFormat:@"http://graph.facebook.com/?id=%@", inEntry.urlStr];
  
  NSURL *url = [NSURL URLWithString:urlStr];
  [NSURLRequest requestWithURL:url];
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  
  [manager GET:[url absoluteString]
    parameters:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
         
         NSDictionary *dict = (NSDictionary*) responseObject;
         NSString *facebookShared = [dict[@"shares"] stringValue];
         inEntry.shareCount += [facebookShared integerValue];
         
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                          [SGNotifications postShareCountUpdated:inEntry];
                        });
         
       }
       failure:^(NSURLSessionDataTask *task, NSError *error)
   {
   }];
}

- (void) updateTwitterCountForEntry:(SGBlogEntry*) inEntry
{
  NSString *urlStr = [NSString stringWithFormat:@"http://cdn.api.twitter.com/1/urls/count.json?url=%@", inEntry.urlStr];
  
  NSURL *url = [NSURL URLWithString:urlStr];
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];
  
  [manager GET:[url absoluteString]
    parameters:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
         
         NSDictionary *dict = (NSDictionary*) responseObject;
         NSString *sharedStr = [dict[@"count"] stringValue];
         inEntry.shareCount += sharedStr.integerValue;
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                          [SGNotifications postShareCountUpdated:inEntry];
                        });
         
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
         
       }];
}

#pragma mark -
#pragma mark parsing

- (NSArray*) itemsFromDictionary:(NSDictionary*) inDictionary
{
  NSArray *items = inDictionary[@"entries"];
  
  NSMutableArray *blogEntries = [NSMutableArray arrayWithCapacity:items.count];
  
  for(NSDictionary *dict in items)
  {
    NSString *displayName   = dict[@"title"];
    NSString *dateStr       = dict[@"published"];
    NSDate   *datePublished = [self dateFromString:dateStr];
    NSString *summary       = dict[@"excerpt"];
    NSString *content       = dict[@"renderedContent"];
    
    content = [self removeUnwantedContentCharactersFrom:content];
    
    NSString *itemID        = dict[@"urlId"];
    NSString *urlStr        = dict[@"permalinkUrl"];
    
    SGBlogEntry *blogEntry = [[SGBlogEntry alloc] initWithTitle:displayName
                                                    publishedOn:datePublished
                                                        summary:summary
                                                        content:content
                                                         itemID:itemID
                              
                                                        fromURL:urlStr];
    [self updateShareCountForBlogEntry:blogEntry];
    [blogEntries addObject:blogEntry];
  }
  
  dispatch_async(dispatch_get_global_queue(0, 0), ^
                 {
                   self.cachedItems = blogEntries;
                 });
  
  return blogEntries;
}

- (NSString*) removeUnwantedContentCharactersFrom:(NSString*) inString
{
  return [inString stringByReplacingOccurrencesOfString:@"Ã¢ÂÂ" withString:@"'"];
}

#pragma mark -
#pragma mark cache

- (BOOL) cacheAvailable
{
  return ![[self cacheKey] isEqualToString:@""];
}

- (NSString*) cacheKey
{
  return @"";
}

- (NSArray*) cachedItems
{
  if(![self cacheAvailable]) return [NSArray array];
  
  NSString *cacheFile = [self cacheFile];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  if(![fileManager fileExistsAtPath:[self cacheFile]]) [NSArray array];
  
  return [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFile];
}

- (void) setCachedItems:(NSArray*) inItems
{
  if(![self cacheAvailable]) return;
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                 {
                   [NSKeyedArchiver archiveRootObject:inItems toFile:[self cacheFile]];
                   [self saveToJson:inItems];
                 });
  
}

- (void) saveToJson:(NSArray*) blogItems
{
  
  NSURL *url = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.spearware.sethgodin"];
  
  NSAssert(url != nil, @"Not able to get URL for group, group.com.spearware.sethgodin");
  
  NSURL *docUrl = [url URLByAppendingPathComponent:@"blogEntries.json"];
  
  NSArray *itemsAsDictionary = [self blogItemsToDictionary:blogItems];
  
  if(![NSJSONSerialization isValidJSONObject:itemsAsDictionary])
  {
    NSLog(@"can't convert to JSON");
    return;
  }
  
  NSError *error;
  
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:itemsAsDictionary options:NSJSONWritingPrettyPrinted error:&error];
  
  if (error)
  {
    NSLog(@"error writing JSON %@", error.localizedDescription);
    return;
  }
  
  NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  if ([jsonStr writeToURL:docUrl atomically:YES encoding:NSUTF8StringEncoding error:&error])
  {
     NSLog(@"cache JSON file written");
  }
  else
  {
    NSLog(@"%@", error);
  }
  
}

- (NSArray*) blogItemsToDictionary:(NSArray*) blogItems
{
  NSMutableArray *blogArray = [NSMutableArray array];
  
  NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setLocale:usLocale];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
  [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
  
  
  for (SGBlogEntry *blogEntry in blogItems)
  {
    NSDictionary *blogDict = @
    {
      @"title" : blogEntry.title,
      @"date" : [dateFormatter stringFromDate:blogEntry.datePublished],
      @"summary" : blogEntry.summary,
      @"content" : blogEntry.content,
      @"itemId" : blogEntry.itemID,
      @"urlStr" : blogEntry.urlStr
    };
    
    if ([NSJSONSerialization isValidJSONObject:blogDict])
    {
      [blogArray addObject:blogDict];
    }
    else
    {
      NSLog(@"Not converatable to JSON");
    }
    
  }
  
  return blogArray;
}

/**
 *  The location and file name of the file to save cache data to
 *
 *  @return location and file name of the file to save cache data to
 */
- (NSString*) cacheFile
{
  NSURL *sharedContainerUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.spearware.sethgodin"];
  
  NSAssert(sharedContainerUrl != nil, @"Wasn't able to get the sharedContainer URL");
  
  NSURL *fullPathUrl = [sharedContainerUrl URLByAppendingPathComponent:[self cacheKey]];
  
  return [fullPathUrl absoluteString];
}

@end
