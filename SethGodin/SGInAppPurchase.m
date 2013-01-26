//
//  SGInAppPurchase.m
//  SethGodin
//
//  Created by Kraig Spear on 11/23/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGInAppPurchase.h"
#import "SGUSerDefaults.h"
#import "Flurry.h"
#import "SGLogger.h"
#import <sys/utsname.h>
#import <Parse/Parse.h>

@implementation SGInAppPurchase
{
@private
    NSArray  *_products;
    NSString *_productID;
}

NSString * const PRODUCT_ID = @"com.andersonspear.sethsblog.upgrade";

+ (id) sharedInstance
{
	static SGInAppPurchase *instance;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      instance = [[SGInAppPurchase alloc] init];
                  });
    
    return instance;
}


- (id) init
{
    self = [super init];
    if(!self) return nil;
    
    [PFPurchase addObserverForProduct:PRODUCT_ID block:^(SKPaymentTransaction *transaction)
    {
        [SGUserDefaults sharedInstance].isUpgraded = YES;
        [self.delegate purchaseCompleteWithID:transaction.transactionIdentifier];
    }];
    
    return self;
}


- (void) purchaseUpgrade
{
    [self purchaseProduct:PRODUCT_ID];
}

- (void) purchaseProduct:(NSString*) inProduct
{
    [PFPurchase buyProduct:PRODUCT_ID block:^(NSError *error)
    {
        if(error)
        {
            [self.delegate didFailWithError:error];
        }
    }];
}

- (void) restorePurchases
{
    [PFPurchase restore];
}

@end
