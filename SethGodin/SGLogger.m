//
//  SGLogger.m
//  SethGodin
//
//  Created by Kraig Spear on 11/23/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGLogger.h"
#import "Flurry.h"

@implementation SGLogger

+ (SGLogger*) sharedInstance
{
    static SGLogger *instance;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      instance = [[SGLogger alloc] init];
                  });
    
    return instance;
}

- (void) logAskToPurchaseFrom:(NSString*) inFrom
{
    NSDictionary *dict = @{@"From" : inFrom};
    [Flurry logEvent:@"AskToPurchase" withParameters:dict];
}

- (void) logPurchasedFrom:(NSString*) inFrom
{
    NSDictionary *dict = @{@"From" : inFrom};
    [Flurry logEvent:@"Purchased" withParameters:dict];
}



@end
