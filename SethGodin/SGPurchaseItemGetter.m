//
//  SGPurchaseItemGetter.m
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGPurchaseItemGetter.h"
#import "AFNetworking.h"
#import "NSDictionary-Expanded.h"
#import "SGPurchaseItem.h"
#import <Parse/Parse.h>

@implementation SGPurchaseItemGetter
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

- (void)main
{
  @weakify(self);

  self.executing = YES;
  PFQuery *query = [PFQuery queryWithClassName:@"Book"];
  NSArray *results = [query findObjects];

  NSMutableArray *bookIds = [[NSMutableArray alloc] init];

  for (PFObject *book in results)
  {
    NSString *trackIdStr = book[@"trackId"];
    NSUInteger trackInt = (NSUInteger) trackIdStr.integerValue;
    NSNumber *trackNum = @(trackInt);
    [bookIds addObject:trackNum];
  }

  [self jsonFromiTunesFilteringIds:bookIds
                           success:^(NSArray *purchaseItems)
                           {
                             @strongify(self);
                             self.purchaseItems = purchaseItems;
                             self.executing = NO;
                             self.finished = YES;
                           }
                           failure:^(NSError *error)
                           {
                             @strongify(self);
                             self.error = error;
                             self.executing = NO;
                             self.finished = YES;
                           }];


};



- (void) jsonFromiTunesFilteringIds:(NSArray*) idsToFilter success:(SWArrayBlock) success failure:(SWErrorBlock) failure
{
  NSString *urlStr = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=Seth%2BGodin&country=US&media=ebook&lang=en";
  NSURL *url = [NSURL URLWithString:urlStr];

  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

  [manager GET:[url absoluteString]
    parameters:nil
       success:^(NSURLSessionDataTask *task, id responseObject)
       {
         //All items coming back from iTunes
         NSArray *items = [self itemsForDictionary:responseObject];

         //iTunes items with the trackId passed in in idsToFilter
         NSIndexSet *filteredIndexSet = [items indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
         {
           SGPurchaseItem *purchaseItem = obj;

           NSNumber *trackIdNum = @(purchaseItem.trackID);

           NSUInteger trackIndex = [idsToFilter indexOfObject:trackIdNum];

           return trackIndex != NSNotFound;
         }];

         NSArray *filteredItems = [items objectsAtIndexes:filteredIndexSet];

         if(success)
         {
           success(filteredItems);
         }

       }
       failure:^(NSURLSessionDataTask *task, NSError *error)
       {
         if(failure)
         {
           failure(error);
         }
       }];
}


- (NSArray*) itemsForDictionary:(NSDictionary*) inDict
{
    const NSInteger sethArtistID = 2072165;
    
    NSInteger count    =  [inDict intForKey:@"resultCount"];
    NSArray   *results = inDict[@"results"];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:(NSUInteger) count];
    
    for(NSDictionary *result in results)
    {
        NSInteger artistID = [result intForKey:@"artistId"];
        if(artistID != sethArtistID) continue;
        
        NSString *title      = result[@"trackName"];
        NSString *dateStr    = [result[@"releaseDate"] substringToIndex:10];
        NSDate   *releasedOn = [_dateFormatter dateFromString:dateStr];
        NSInteger trackID    = [result intForKey:@"trackId"];
        NSString *imageURL   = result[@"artworkUrl100"];
        
        imageURL = [imageURL stringByReplacingOccurrencesOfString:@".100x100-75.jpg" withString:@".450x450-75.jpg"];
        
        SGPurchaseItem *purchaseItem = [[SGPurchaseItem alloc] initWithTitle:title artest:(NSUInteger) artistID releasedOn:releasedOn trackId:(NSUInteger) trackID imageURL:imageURL];
        
        [items addObject:purchaseItem];
        [self fetchImageForPurchaseItem:purchaseItem];
    }
    
    [items sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        SGPurchaseItem *item1 = (SGPurchaseItem*) obj1;
        SGPurchaseItem *item2 = (SGPurchaseItem*) obj2;
        
        NSTimeInterval timeInterval1 = [item1.releasedDate timeIntervalSinceReferenceDate];
        NSTimeInterval timeInterval2 = [item2.releasedDate timeIntervalSinceReferenceDate];
        
        if(timeInterval1 < timeInterval2)
            return NSOrderedDescending;
        else
            return NSOrderedAscending;
        
    }];
    
    return items;
}

- (void)fetchImageForPurchaseItem:(SGPurchaseItem*) inItem
{
    NSURL *url = [NSURL URLWithString:inItem.imageURL];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    inItem.image = image;
}


@end
