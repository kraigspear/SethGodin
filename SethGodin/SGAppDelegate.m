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
#import "SGUSerDefaults.h"
#import "SGFavorites.h"
#import "SGNotifications.h"
#import "SGBlogEntry.h"
#import "SGFavoritesParse.h"

#import <Parse/Parse.h>

@implementation SGAppDelegate
{
@private
    NSDateFormatter *_dateformatter;
}

- (NSDateFormatter*) dateFormatterLongStyle
{
    return _dateformatter;
}

+ (SGAppDelegate*) instance
{
    return (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
}

//Helvetica Neue Condensed Black 26.0
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Flurry startSession:@"5Y7GYTZD4NPMH2N35DPT"];
    
    [Parse setApplicationId:@"k2eo7GeSve5neSkhTFcMLPtIViPicZwLf3opy9bu"
                  clientKey:@"c46oSNaIeVXYVONk0D9wPVxYfBrdZZu0K8Od95wN"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _dateformatter           = [[NSDateFormatter alloc] init];
    _dateformatter.dateStyle =  NSDateFormatterLongStyle;
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"SethGodin.sqllite"];
    
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
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
}




@end
