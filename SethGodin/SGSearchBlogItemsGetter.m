//
//  SGSearchBlogItemsGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGSearchBlogItemsGetter.h"
#import "AFHTTPSessionManager.h"

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

- (void) main
{
    @weakify(self);
    
    self.executing = YES;
    NSString *searchTextEscaped = [_searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.typepad.com/assets.json?q=title:%@&filter.author=6p00d83451b31569e2", searchTextEscaped];
    
    NSLog(@"search URL = %@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
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
                            @strongify(self);
                            self.error = error;
                            [self done];
                        });
         
     }];

    
}


@end
