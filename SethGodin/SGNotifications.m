//
//  SGNotifications.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGNotifications.h"

@implementation SGNotifications

NSString * const NOTIFICATION_FEED_SELECTION    = @"feedSelection";
NSString * const NOTIFICATION_NETWORK_AVAILABLE = @"networkAvailable";
NSString * const 


+ (SGNotifications*) sharedInstance
{
    static SGNotifications *instance;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      instance = [[SGNotifications alloc] init];
                  });
    
    return instance;
}

- (void) postFeedSelection:(SGFeedSelection*) inSelection;
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_FEED_SELECTION object:inSelection];
    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

- (id) observeFeedSelectionWithNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_FEED_SELECTION object:nil queue:nil usingBlock:inBlock];
}

- (void) postNetworkAvailable:(BOOL) isAvailable
{
    NSNotification *notificaiton = [NSNotification notificationWithName:NOTIFICATION_NETWORK_AVAILABLE object:[NSNumber numberWithBool:isAvailable]];

    [[NSNotificationCenter defaultCenter] postNotification:notificaiton];
}

- (id) observeNetworkAvailableWithNotification:(NotificationBlock) inBlock
{
    return [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_NETWORK_AVAILABLE object:nil queue:nil usingBlock:inBlock];
}


@end
