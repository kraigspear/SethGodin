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

/**
 Set to YES to use iCloud
 */
- (void) setUseICloud:(BOOL) toValue;

/**
 Yes or no to use iCloud
 */
- (BOOL) useICloud;

/**
 Have we moved the non-UIDocument over to UIDocument yet?
 */
- (BOOL) movedToUIDocument;

/**
 Update that we have moved the non-UIDocument over to UIDocument
 */
- (void) setMovedToUIDocument:(BOOL) toValue;

@end
