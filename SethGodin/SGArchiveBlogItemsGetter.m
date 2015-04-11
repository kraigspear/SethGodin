//
//  SGArchiveContentGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGArchiveBlogItemsGetter.h"
#import "AFHTTPSessionManager.h"

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

- (void)main
{
  self.executing = YES;
  NSString *monthYear = [NSString stringWithFormat:@"%lu-%02lu", (unsigned long)_year, (unsigned long)_month];

  NSString *urlStr = [NSString stringWithFormat:@"http://api.typepad.com/blogs/6a00d83451b31569e200d8341c521b53ef/post-assets/@published/@by-month/%@.json?max-results=31", monthYear];

  NSURL *url = [NSURL URLWithString:urlStr];

  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  manager.requestSerializer = [AFJSONRequestSerializer serializer];

  [manager GET:[url absoluteString]
    parameters:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
         NSArray *items = [self itemsFromDictionary:responseObject];

         self.cachedItems = items;
         dispatch_async(dispatch_get_main_queue(), ^
         {
           self.blogEntries = items;
         });

       }
       failure:^(NSURLSessionDataTask *task, NSError *error)
       {
         self.error = error;
       }];
}


@end
