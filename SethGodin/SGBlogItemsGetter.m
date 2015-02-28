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

//Abstract. Should be extended by inherited classes.
- (BFTask*)requestItems
{
    BFTaskCompletionSource *source = [BFTaskCompletionSource taskCompletionSource];

    NSArray *cacheItems = self.cachedItems;

    if (cacheItems.count >= 1)
    {
        [source setResult:cacheItems];
    }

    return source.task;
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
    [NSKeyedArchiver archiveRootObject:inItems toFile:[self cacheFile]];
}

- (NSString*) cacheFile
{
    return [NSFileManager cachePathWithFile:[self cacheKey]];
}

@end
