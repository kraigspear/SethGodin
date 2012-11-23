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
#import <sys/utsname.h>

@implementation SGInAppPurchase
{
@private
    NSArray  *_products;
    NSString *_productID;
}

NSString * const PRODUCT_ID = @"com.andersonspear.sethsblog.upgrade";

- (id) init
{
    self = [super init];
    if(!self) return nil;
    
    //need to listen to payment que.
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    return self;
}

- (void) loadProducts
{
    NSArray *productIdentifiers = @[PRODUCT_ID];
    
    NSSet *identifierSet = [NSSet setWithArray:productIdentifiers];
    
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:identifierSet];
    
    request.delegate = self;
    [request start];
}

- (void) purchaseUpgrade
{
    [self purchaseProduct:PRODUCT_ID];
}

- (void) purchaseProduct:(NSString*) inProduct
{
    if(!_products)
    {
        _productID = [inProduct copy];
        [self loadProducts];
        return;
    }
    
    _productID = nil;
    
    SKProduct *product = [self productForID:inProduct];
    
    if(!product)
    {
        NSLog(@"Product missing!!!!");
        return;
    }
    
    //This will start the payment process.
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (SKProduct*) productForID:(NSString*) inID
{
    SKProduct *product;
    
    NSUInteger index = [_products indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
    {
        NSString *productID = [obj productIdentifier];
        
        if([productID isEqualToString:inID])
        {
            *stop = YES;
            return YES;
        }
        else
        {
            return NO;
        }

    }];
    
    if(index != NSNotFound)
    {
        product = [_products objectAtIndex:index];
    }
    
    return product;
    
}

#pragma mark -
#pragma mark SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    _products = response.products;
    
    for(SKProduct *p in _products)
    {
        NSLog(@"product received %@", p.productIdentifier);
    }
    
    for(NSString *invalidProduct in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product!!!! %@", invalidProduct);
    }
    
    if(_productID)
    {
        [self purchaseProduct:_productID];
    }
}

- (void) request:(SKRequest *)request didFailWithError:(NSError *)error
{
    [self.delegate didFailWithError:error];
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for(SKPaymentTransaction *trans in transactions)
    {
        switch (trans.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self purchasedProductFromTransaction:trans];
                break;
            case SKPaymentTransactionStateRestored:
                [self purchasedProductFromTransaction:trans];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"SKPaymentTransactionStateFailed %@", trans.error);
                [self.delegate didFailWithError:trans.error];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"SKPaymentTransactionStatePurchasing %@", trans);
                break;
            default:
                break;
        }
    }

}

- (void) purchasedProductFromTransaction:(SKPaymentTransaction*) transAction
{
    SGUserDefaults.sharedInstance.isUpgraded = YES;
    [self.delegate purchaseCompleteWithID:transAction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transAction];
}

- (void) updateFlurryPurchaedForTransaction:(SKPaymentTransaction*) inTransaction
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceName = [NSString stringWithCString:systemInfo.machine
                                              encoding:NSUTF8StringEncoding];
    
    NSArray *items = [NSArray arrayWithObjects:deviceName,
                      inTransaction.payment.productIdentifier,
                      nil];
    
    NSArray *keys = [NSArray arrayWithObjects:@"device",  @"product", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:items forKeys:keys];
    
    [Flurry logEvent:@"upgraded" withParameters:dict];
    
}



@end
