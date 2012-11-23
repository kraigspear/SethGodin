//
//  SGInAppPurchase.h
//  SethGodin
//
//  Created by Kraig Spear on 11/23/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol SGInAppPurchaseDelegate <NSObject>

- (void) purchaseCompleteWithID:(NSString*) inId;
- (void) didFailWithError:(NSError*) inError;

@end

/**
 Responsible for purchasing content
 */
@interface SGInAppPurchase : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>


@property (nonatomic, weak) id<SGInAppPurchaseDelegate> delegate;

@end
