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


//http://profile.typepad.com/sethgodin/activity.json

@implementation SGCurrentBlogItemsGetter
{
@private
    
}

- (void) requestItemssuccess:(BlogContentSuccess) inSuccess failed:(BlogContentFailed) inError
{
    NSURL *url = [NSURL URLWithString:@"http://profile.typepad.com/sethgodin/activity.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         
         dispatch_async(dispatch_get_global_queue(0, 0), ^
                        {
                             NSArray *items = [self blockItemsForDictionary:JSON];
                             dispatch_async(dispatch_get_main_queue(), ^
                                           {
                                               inSuccess(items);
                                           });
                        });
         
     } failure:^(NSURLRequest *request, NSURLResponse *response, NSError  *error, id JSON)
     {
         inError(error);
     }];
    [operation start];
}

- (NSArray*) blockItemsForDictionary:(NSDictionary*) inDictionary
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



@end
