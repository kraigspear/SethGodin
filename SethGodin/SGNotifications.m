//
//  SGNotifications.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGNotifications.h"

@implementation SGNotifications

NSString * const NOTIFICATION_FEED_SELECTION      = @"feedSelection";
NSString * const NOTIFICATION_NETWORK_AVAILABLE   = @"networkAvailable";
NSString * const NOTIFICATION_FAVORITES_UPDATED   = @"favoritesUpdated";
NSString * const NOTIFICATION_FAVORITES_CREATED   = @"favoritesCreated";
NSString * const NOTIFICATION_BUSY                = @"busy";
NSString * const NOTIFICATION_ERROR               = @"errorOccured";
NSString * const NOTIFICATION_SHARE_COUNT_UPDATED = @"shareCountUpdated";
NSString * const NOTIFICATION_BLOG_ENTRY_SELECTED = @"blogEntrySelected";

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

+ (void) postBlogEntrySelected:(SGBlogEntry*) inBlogEntry
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_BLOG_ENTRY_SELECTED object:inBlogEntry];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postNetworkAvailable:(BOOL) isAvailable
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_NETWORK_AVAILABLE object:[NSNumber numberWithBool:isAvailable]];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postBusy:(BOOL) isBusy
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_BUSY object:[NSNumber numberWithBool:isBusy]];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postFavoritesUpdated
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_FAVORITES_UPDATED object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postFavoritesCreated
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_FAVORITES_CREATED object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

+ (void) postErrorOccured:(NSError*) inError
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_ERROR object:inError];
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
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

+ (id) observeBusyWithNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_BUSY object:nil queue:nil usingBlock:inBlock];
}

+ (id) observeFavoritesUpdatedNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FAVORITES_UPDATED object:nil queue:nil usingBlock:inBlock];
}

+ (id) observeFavoritesCreatedNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FAVORITES_CREATED object:nil queue:nil usingBlock:inBlock];
}




@end
