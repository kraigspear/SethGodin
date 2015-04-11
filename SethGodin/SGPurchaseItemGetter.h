//
//  SGPurchaseItemGetter.h
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockTypes.h"
#import "STBaseOperation.h"


/**
 Gets items that can be purchased
 */
@interface SGPurchaseItemGetter : STBaseOperation

@property (nonatomic, retain) NSArray *purchaseItems;

@end
