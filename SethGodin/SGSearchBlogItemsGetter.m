//
//  SGSearchBlogItemsGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGSearchBlogItemsGetter.h"
#import "AFJSONRequestOperation.h"
#import "SGBlogEntry.h"
#import "Flurry.h"

@implementation SGSearchBlogItemsGetter
{
@private
    NSString *_searchText;
}

- (id) initWithSearchText:(NSString*) inSearchText
{
    self = [self init];
    
    _searchText = inSearchText;
    
    return self;
}

- (void) requestItemssuccess:(SWArrayBlock) inSuccess failed:(SWErrorBlock) inError
{
    
    NSString *searchTextEscaped = [_searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.typepad.com/assets.json?q=title:%@&filter.author=6p00d83451b31569e2", searchTextEscaped];
    
    NSLog(@"search URL = %@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMEOUT];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             
                                             dispatch_async(dispatch_get_global_queue(0, 0), ^
                                                            {
                                                                NSArray *items = [self itemsFromDictionary:JSON];
                                                                
                                                                NSDictionary *params = @{@"SearchText" : _searchText,
                                                                                @"Results" : [NSNumber numberWithInt:items.count]};
                                                                
                                                                [Flurry logEvent:@"Search" withParameters:params];
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), ^
                                                                               {
                                                                                   NSLog(@"search found %d items", items.count);
                                                                                   inSuccess(items);
                                                                               });
                                                            });
                                             
                                         } failure:^(NSURLRequest *request, NSURLResponse *response, NSError  *error, id JSON)
                                         {
                                             [Flurry logError:@"SearchError" message:[NSString stringWithFormat:@"error searching for %@", _searchText] error:error];
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^
                                                            {
                                                                inError(error);
                                                            });
                                         }];
    [operation start];

}


@end
