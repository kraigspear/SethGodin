//
//  SGNotifications.h
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGFeedSelection.h"
#import "SGBlogEntry.h"


typedef void (^NotificationBlock) (NSNotification* notification);

@interface SGNotifications : NSObject


extern NSString * const NOTIFICATION_FEED_SELECTION;
extern NSString * const NOTIFICATION_NETWORK_AVAILABLE;
extern NSString * const NOTIFICATION_FAVORITES_UPDATED;
extern NSString * const NOTIFICATION_BUSY;
extern NSString * const NOTIFICATION_SHARE_COUNT_UPDATED;

/**
 Post that a feed type was selected
 @param inSelection The selection information
 */
+ (void) postFeedSelection:(SGFeedSelection*) inSelection;

/**
 Post that a blog entry was selected.
 @param inBlogEntry Entry that has been selected.
 */
+ (void) postBlogEntrySelected:(SGBlogEntry*) inBlogEntry;

/**
 Share count updated for this BlogEntry
 @param inBlogEntry
 */
+ (void) postShareCountUpdated:(SGBlogEntry*) inBlogEntry;

/**
 Post that the menu button has been selected
 @param isSelected Yes if the menu selected, NO if the menu is not selected
 */
+ (void) postMenuSelectedNotification:(BOOL) isSelected;

/**
 Observe that the menu button has been selected
 */
+ (id) observeMenuSelectedNotification:(NotificationBlock) inBlock;


/**
 Observe that a share count has been updated
 */
+ (id) observeShareCountUpdated:(NotificationBlock) inBlock;

/**
 Observe that a blog entry item has been selected
 @param inBlock block to recive the message
 */
+ (id) observeBlogEntrySelectedNotification:(NotificationBlock) inBlock;

/**
 Observe Feed selection changing
 */
+ (id) observeFeedSelectionWithNotification:(NotificationBlock) inBlock;

/**
 Observe network available
 */
+ (id) observeNetworkAvailableWithNotification:(NotificationBlock) inBlock;

/**
 Observe that a BlogEntry is no longer a favorite.
 */
+ (id) observeFavoriteDeleted:(NotificationBlock) inBlock;

/**
 Post that the network availablity has changed.
 @param isAvailable Yes is available
 */
+ (void) postNetworkAvailable:(BOOL) isAvailable;

/**
 Send a notification that a blog entry is no longer a favorite
 */
+ (void) postFavoriteDeleted:(SGBlogEntry*) blogEntry;

/**
 Post that a favorite has been added
 */
+ (void) postFavoriteAdded:(SGBlogEntry*) blogEntry;

/**
 Observe that a favorite has been added.
 */
+ (id) observeFavoriteAdded:(NotificationBlock) inBlock;

@end
