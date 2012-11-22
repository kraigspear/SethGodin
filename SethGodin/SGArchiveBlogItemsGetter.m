//
//  SGArchiveContentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGArchiveBlogItemsGetter.h"
#import "AFJSONRequestOperation.h"
#import "SGBlogEntry.h"

@implementation SGArchiveBlogItemsGetter
{
@private
    NSUInteger _year;
    NSUInteger _month;
}

- (id) initWithMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear
{
    self = [self init];
    
    if(self)
    {
        _month = inMonth;
        _year  = inYear;
    }
    
    return self;
}

- (void) requestItemssuccess:(ArrayBlock) inSuccess failed:(ErrorBlock) inError
{
    NSString *monthYear = [NSString stringWithFormat:@"%d-%02d", _year, _month];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.typepad.com/blogs/6a00d83451b31569e200d8341c521b53ef/post-assets/@published/@by-month/%@.json?max-results=31", monthYear];
    
    NSLog(@"urlStr = %@", urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             
                                             dispatch_async(dispatch_get_global_queue(0, 0), ^
                                                            {
                                                                NSArray *items = [self itemsFromDictionary:JSON];
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


@end
