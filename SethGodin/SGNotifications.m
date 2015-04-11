//
//  SGNotifications.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGNotifications.h"

@implementation SGNotifications

NSString * const NOTIFICATION_FEED_SELECTION       = @"feedSelection";
NSString * const NOTIFICATION_NETWORK_AVAILABLE    = @"networkAvailable";
NSString * const NOTIFICATION_SHARE_COUNT_UPDATED  = @"shareCountUpdated";
NSString * const NOTIFICATION_BLOG_ENTRY_SELECTED  = @"blogEntrySelected";
NSString * const NOTIFICATION_MENU_SELECTED        = @"menuSelected";
NSString * const NOTIFICATION_FAVORITE_DELETED        = @"favoriteDeleted";
NSString * const NOTIFICATION_FAVORITE_ADDED        = @"favoriteAdded";

+ (void) postFeedSelection:(SGFeedSelection*) inSelection;
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_FEED_SELECTION object:inSelection];
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postShareCountUpdated:(SGBlogEntry*) inBlogEntry
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_SHARE_COUNT_UPDATED object:inBlogEntry];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postMenuSelectedNotification:(BOOL) isSelected
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MENU_SELECTED object:@(isSelected)];
}

+ (void) postBlogEntrySelected:(SGBlogEntry*) inBlogEntry
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_BLOG_ENTRY_SELECTED object:inBlogEntry];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postNetworkAvailable:(BOOL) isAvailable
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_NETWORK_AVAILABLE object:@(isAvailable)];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postFavoriteAdded:(SGBlogEntry*) blogEntry
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_FAVORITE_ADDED object:blogEntry];
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (id) observeFavoriteAdded:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FAVORITE_ADDED object:nil queue:nil usingBlock:inBlock];
}

+ (id) observeFavoriteDeleted:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FAVORITE_DELETED object:nil queue:nil usingBlock:inBlock];
}

+ (void) postFavoriteDeleted:(SGBlogEntry*) blogEntry
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_FAVORITE_DELETED object:blogEntry];
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (id) observeMenuSelectedNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_MENU_SELECTED object:nil queue:nil usingBlock:inBlock];
}

+ (id) observeBlogEntrySelectedNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_BLOG_ENTRY_SELECTED object:nil queue:nil usingBlock:inBlock];
}

+ (id) observeFeedSelectionWithNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FEED_SELECTION object:nil queue:nil usingBlock:inBlock];
}

+ (id) observeShareCountUpdated:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_SHARE_COUNT_UPDATED object:nil queue:nil usingBlock:inBlock];
}

+ (id) observeNetworkAvailableWithNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_NETWORK_AVAILABLE object:nil queue:nil usingBlock:inBlock];
}


@end
