//
//  SGConentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogItemsGetter.h"
#import "SGBlogEntry.h"
#import "AFJSONRequestOperation.h"


@implementation SGBlogItemsGetter
{
@private
    NSDateFormatter *_dateFormatter;
}

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

- (void) requestItemssuccess:(ArrayBlock) inSuccess failed:(ErrorBlock) inError
{
    
}

- (NSDate*) dateFromString:(NSString*) inDateStr
{
    NSString *dateStr      = [inDateStr substringToIndex:10];
    NSDate *dateFromFormat = [_dateFormatter dateFromString:dateStr];
    return dateFromFormat;
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
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             NSDictionary *dict = (NSDictionary*) JSON;
                                             
                                             
                                             NSString *facebookShared = [[dict objectForKey:@"shares"] stringValue];
                                             
                                             inEntry.shareCount += [facebookShared integerValue];
                                         } failure:^(NSURLRequest *request, NSURLResponse *response, NSError  *error, id JSON)
                                         {
                                             
                                         }];
    
    [operation start];
    
}

- (void) updateTwitterCountForEntry:(SGBlogEntry*) inEntry
{
    NSString *urlStr = [NSString stringWithFormat:@"http://cdn.api.twitter.com/1/urls/count.json?url=%@", inEntry.urlStr];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             NSDictionary *dict = (NSDictionary*) JSON;
                                             
                                             
                                             NSString *sharedStr = [[dict objectForKey:@"count"] stringValue];
                                             
                                             inEntry.shareCount += [sharedStr integerValue];
                                         } failure:^(NSURLRequest *request, NSURLResponse *response, NSError  *error, id JSON)
                                         {
                                             
                                         }];
    
    [operation start];
    
}

- (NSArray*) blockItemsForDictionary:(NSDictionary*) inDictionary
{
    NSArray *items = [inDictionary objectForKey:@"entries"];
    
    NSMutableArray *blogEntires = [NSMutableArray arrayWithCapacity:items.count];
    
    for(NSDictionary *dict in items)
    {
        NSString *displayName   = [dict objectForKey:@"title"];
        NSString *dateStr       = [dict objectForKey:@"published"];
        NSDate   *datePublished = [self dateFromString:dateStr];
        NSString *summary       = [dict objectForKey:@"excerpt"];
        NSString *content       = [dict objectForKey:@"renderedContent"];
        NSString *itemID        = [dict objectForKey:@"urlId"];
        NSString *urlStr        = [dict objectForKey:@"permalinkUrl"];
        
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




@end
