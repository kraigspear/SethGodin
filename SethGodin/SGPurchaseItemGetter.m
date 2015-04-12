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
#import "Seth_Godin-Swift.h"
#import <Parse/Parse.h>

@implementation SGPurchaseItemGetter
{
@private
    NSDateFormatter *_dateFormatter;
    //Que to load all of the images
    NSOperationQueue *_imageLoadingQue;
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
        _imageLoadingQue = [[NSOperationQueue alloc] init];
        _imageLoadingQue.name = @"imageLoadingQue";
    }
    
    return self;
}

- (void)main
{
    self.executing = YES;
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    NSArray *results = [query findObjects];
    
    NSMutableArray *purchaseItems = [[NSMutableArray alloc] init];
    NSMutableArray *imageDownloaders = [[NSMutableArray alloc] init];
    
    
    for (PFObject *book in results)
    {
        NSString *trackIdStr = book[@"trackId"];
        NSUInteger trackInt = (NSUInteger) trackIdStr.integerValue;
        NSString *titleStr = book[@"title"];
        NSDate *released = book[@"released"];
        PFFile *thumbNail = book[@"image"];
        
        SGPurchaseItem *purchaseItem = [[SGPurchaseItem alloc] initWithTitle:titleStr
                                                                  releasedOn:released
                                                                     trackId: trackInt];
        [purchaseItems addObject:purchaseItem];
        
        SGImageDownloader *imageDownloader = [[SGImageDownloader alloc] initWithPurchaseItem:purchaseItem parseFile:thumbNail];
        [imageDownloaders addObject:imageDownloader];
    }
    
    self.purchaseItems = purchaseItems;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       [_imageLoadingQue addOperations:imageDownloaders waitUntilFinished:YES];
                       [self done];
                   });
};

@end
