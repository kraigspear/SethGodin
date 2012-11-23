//
//  SGLogger.h
//  SethGodin
//
//  Created by Kraig Spear on 11/23/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGLogger : NSObject

+ (SGLogger*) sharedInstance;
- (void) logAskToPurchaseFrom:(NSString*) inFrom;
- (void) logPurchasedFrom:(NSString*) inFrom;


@end
