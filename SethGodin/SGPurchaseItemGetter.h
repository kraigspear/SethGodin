//
//  SGPurchaseItemGetter.h
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockTypes.h"

/**
 Get's items that can be purchased
 */
@interface SGPurchaseItemGetter : NSObject


/**
 Gets the latest purchasable items.
 */
- (void) latestItems:(SWArrayBlock) inSuccess failed:(SWErrorBlock) inFailed;

@end
