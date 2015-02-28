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

- (BFTask*) latestBooksFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    return [[query findObjectsInBackground] continueWithSuccessBlock:^id(BFTask *task)
    {
        NSArray *books = task.result;
        NSMutableArray *bookIds = [[NSMutableArray alloc] init];
        
        for (PFObject *book in books)
        {
            NSString *trackIdStr = book[@"trackId"];
            NSUInteger trackInt = (NSUInteger) trackIdStr.integerValue;
            NSNumber *trackNum = [NSNumber numberWithUnsignedLong:trackInt];
            [bookIds addObject:trackNum];
        }
        
        return bookIds;
    }];
}

- (BFTask*) latestFromiTunes
{
     return [[self latestBooksFromParse] continueWithSuccessBlock:^id(BFTask *task)
     {
          NSArray *trackIds = task.result;
          return [self jsonFromiTunesFilteringIds:trackIds];
     }];
}

- (BFTask*) jsonFromiTunesFilteringIds:(NSArray*) idsToFilter
{
    NSString *urlStr = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=Seth%2BGodin&country=US&media=ebook&lang=en";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    BFTaskCompletionSource *source = [BFTaskCompletionSource taskCompletionSource];
    
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
                 
                 NSNumber *trackIdNum = [NSNumber numberWithUnsignedLong:purchaseItem.trackID];
                 
                 NSUInteger trackIndex = [idsToFilter indexOfObject:trackIdNum];
                 
                 return trackIndex != NSNotFound;
             }];
             
             NSArray *filteredItems = [items objectsAtIndexes:filteredIndexSet];
             
             [source setResult:filteredItems];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [source setError:error];
         }];
    
    return source.task;
}

- (void) latestItems:(SWArrayBlock) inSuccess failed:(SWErrorBlock) inFailed
{

    [[self latestFromiTunes] continueWithBlock:^id(BFTask *task)
    {

        if(task.error)
        {
            inFailed(task.error);
        }
        else
        {
            inSuccess(task.result);
        }

        return nil;

    }];


};

- (NSString*) cacheFile
{
    NSArray *documentDirectories =
	NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [documentDirectories[0] stringByAppendingPathComponent:@"storeitems.dat"];
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
        
        SGPurchaseItem *purchaseItem = [[SGPurchaseItem alloc] initWithTitle:title artest:(NSUInteger) artistID releasedOn:releasedOn trackId:trackID imageURL:imageURL];
        
        [items addObject:purchaseItem];
        [self fetchImageforPurchaseItem:purchaseItem];
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

- (void) fetchImageforPurchaseItem:(SGPurchaseItem*) inItem
{
    NSURL *url = [NSURL URLWithString:inItem.imageURL];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    inItem.image = image;
}


@end
