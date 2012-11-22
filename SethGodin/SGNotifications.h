//
//  SGNotifications.h
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGFeedSelection.h"

typedef void (^NotificationBlock) (NSNotification*);

@interface SGNotifications : NSObject

extern NSString * const NOTIFICATION_FEED_SELECTION;
extern NSString * const NOTIFICATION_NETWORK_AVAILABLE;

/**
 Shared instance
 */
+ (SGNotifications*) sharedInstance;

/**
 Post that a feed type was selected
 @param inSelection The selection information
 */
- (void) postFeedSelection:(SGFeedSelection*) inSelection;


/**
 Observe Feed selection changing
 */
- (id) observeFeedSelectionWithNotification:(NotificationBlock) inBlock;

/**
 Observe network available
 */
- (id) observeNetworkAvailableWithNotification:(NotificationBlock) inBlock;

/**
 Post that the network availablity has changed.
 @param isAvailable Yes is available
 */
- (void) postNetworkAvailable:(BOOL) isAvailable;

@end
