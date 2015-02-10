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

@implementation SGPurchaseItemGetter
{
@private
    NSDateFormatter *_dateFormatter;
    dispatch_queue_t _imageLoadingQue;
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
        _imageLoadingQue = dispatch_queue_create("com.seth.imageloader", NULL);
    }
    
    return self;
}

- (void) latestItems:(SWArrayBlock) inSuccess failed:(SWErrorBlock) inFailed
{
    NSString *cacheFile = [self cacheFile];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:cacheFile])
    {
        NSArray *items = [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFile];
        inSuccess(items);
    }
    
    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *langCode = [locale objectForKey:NSLocaleLanguageCode];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];

    NSString *country = [NSString stringWithFormat:@"%@_%@", langCode, countryCode];
    
    NSString *iTunesURLBase = [NSString stringWithFormat:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=Seth+Godin&country=US&media=ebook&lang=%@", country];
    
    NSURL *url = [NSURL URLWithString:iTunesURLBase];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             
             NSArray *items = [self itemsForDictionary:responseObject];
             
             [NSKeyedArchiver archiveRootObject:items toFile:cacheFile];
             
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                inSuccess(items);
                            });
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             inFailed(error);
         }];
}

- (NSString*) cacheFile
{
    NSArray *documentDirectories =
	NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[documentDirectories objectAtIndex:0] stringByAppendingPathComponent:@"storeitems.dat"];
}

- (NSArray*) itemsForDictionary:(NSDictionary*) inDict
{
    const NSInteger sethArtistID = 2072165;
    
    NSInteger count    =  [inDict intForKey:@"resultCount"];
    NSArray   *results =  [inDict objectForKey:@"results"];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:count];
    
    for(NSDictionary *result in results)
    {
        NSInteger artistID = [result intForKey:@"artistId"];
        if(artistID != sethArtistID) continue;
        
        NSString *title      = [result objectForKey:@"trackName"];
        NSString *dateStr    = [[result objectForKey:@"releaseDate"] substringToIndex:10];
        NSDate   *releasedOn = [_dateFormatter dateFromString:dateStr];
        NSInteger trackID    = [result intForKey:@"trackId"];
        NSString *imageURL   = [result objectForKey:@"artworkUrl100"];
        
        imageURL = [imageURL stringByReplacingOccurrencesOfString:@".100x100-75.jpg" withString:@".450x450-75.jpg"];
        
       // NSLog(@"imageURL = %@", imageURL);
        //size = 298x450 = 152
        
        SGPurchaseItem *purchaseItem = [[SGPurchaseItem alloc] initWithTitle:title artest:artistID releasedOn:releasedOn trackId:trackID imageURL:imageURL];
        
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
