//
//  SGBlogContentGetter.h
//  SethGodin
//
//  Created by Kraig Spear on 11/10/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGBlogItemsGetter.h"
#import "STBaseOperation.h"


@interface SGCurrentBlogItemsGetter : SGBlogItemsGetter

/**
 *  Init passing in a flag to indicate that a full refresh should be done regardless of the age of the cache.
 *
 *  @param force Force a refresh
 *
 *  @return Instance of SGCurrentBlogItemsGetter
 */
- (instancetype) initWithForceRefresh:(BOOL) force;

@end
