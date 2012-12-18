//
//  SGAppDelegate.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGAppDelegate.h"
#import "Flurry.h"
#import "SGInAppPurchase.h"
#import "Crittercism.h"
#import "SGUSerDefaults.h"
#import "SGFavorites.h"
#import "SGFavoritesLoader.h"
#import "SGNotifications.h"
#import "SGFavoritesDocument.h"

@implementation SGAppDelegate
{
@private
    NSDateFormatter *_dateformatter;
}

- (NSDateFormatter*) dateFormatterLongStyle
{
    return _dateformatter;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Flurry startSession:@"5Y7GYTZD4NPMH2N35DPT"];
    [Crittercism enableWithAppID:@"50c92afd63d95269e3000002"];
    
    _dateformatter           = [[NSDateFormatter alloc] init];
    _dateformatter.dateStyle =  NSDateFormatterLongStyle;
    
    [SGInAppPurchase sharedInstance];
    
    [self loadFavorites];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) loadFavorites
{
    
    [SGNotifications observeFavoritesCreatedNotification:^(NSNotification *notification)
    {
        SGFavorites *favorites = [SGFavorites loadFavoritesNotUsingUIDocument];
        [SGFavoritesLoader sharedInstance].favoritesDoc.cloudData = favorites;
        [[SGFavoritesLoader sharedInstance].favoritesDoc saveDocument];
        [[SGUserDefaults sharedInstance] setMovedToUIDocument:YES];
    }];
    
    
    [[SGFavoritesLoader sharedInstance] loadDocument];
}

@end
