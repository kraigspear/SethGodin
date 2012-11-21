//
//  SGUSerDefaults.h
//  SethGodin
//
//  Created by Kraig Spear on 11/21/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGUserDefaults : NSObject

+ (SGUserDefaults*) sharedInstance;

/**
 Yes if the user has upgraded
 */
- (BOOL) isUpgraded;

/**
 set if the user has upgraded
 @param toValue value for upgraded
 */
- (void) setIsUpgraded:(BOOL) toValue;


@end
