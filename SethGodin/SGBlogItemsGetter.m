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

- (void) requestItemssuccess:(BlogContentSuccess) inSuccess failed:(BlogContentFailed) inError
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



@end
