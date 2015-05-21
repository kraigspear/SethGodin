//
//  SGAppDelegate.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGAppDelegate.h"

#import <Parse/Parse.h>
#import "Raygun.h"
#import "SGBlogEntriesViewController.h"
#import "SGCurrentBlogItemsGetter.h"
#import "Seth_Godin-Swift.h"

@implementation SGAppDelegate
{
@private
  NSDateFormatter *_dateformatter;
  FeedLoader *_feedLoader;
  NSOperationQueue *_que;
  WatchKitFetcher *_watchKitFetcher;
  SGCurrentBlogItemsGetter *_currentBlogItemsGetter;
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
  
  [Raygun sharedReporterWithApiKey:@"sggD8Qki94kV1fiQjC4fjg=="];
  
  _que = [[NSOperationQueue alloc] init];
  _que.name = @"fetch";
  
  if (IS_IPAD)
  {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
  }
  
  [Parse setApplicationId:@"k2eo7GeSve5neSkhTFcMLPtIViPicZwLf3opy9bu"
                clientKey:@"c46oSNaIeVXYVONk0D9wPVxYfBrdZZu0K8Od95wN"];
  
  [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
  
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
  [self setupForPush:application];
  
  _dateformatter           = [[NSDateFormatter alloc] init];
  _dateformatter.dateStyle =  NSDateFormatterLongStyle;
  
  return YES;
}

/**
 *  Setup the App to receive push notifications.
 *
 *  @param application Application object from didFinishLaunching
 */
- (void) setupForPush:(UIApplication*) application
{
  UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
  UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes  categories:nil];
  [application registerUserNotificationSettings:settings];
  [application registerForRemoteNotifications];
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  // Store the deviceToken in the current Installation and save it to Parse
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation setDeviceTokenFromData:deviceToken];
  [currentInstallation saveInBackground];
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
  
  __weak typeof(self) weakSelf = self;

  //Here's where we left off. Updating based on a push notification.
  _currentBlogItemsGetter = [[SGCurrentBlogItemsGetter alloc] initWithForceRefresh:YES];
  
  _currentBlogItemsGetter.completionBlock = ^
  {
    
    typeof(self) strongSelf = weakSelf;
    
    if(strongSelf)
    {
      SGCurrentBlogItemsGetter *blogItemsGetter = strongSelf->_currentBlogItemsGetter;
      
      if(blogItemsGetter.error)
      {
         completionHandler(UIBackgroundFetchResultFailed);
      }
      else
      {
         completionHandler(UIBackgroundFetchResultNewData);
      }
      
      strongSelf->_currentBlogItemsGetter = nil;
      
      //You are here, we want the UI to be up to date after new content has been loaded in the background.
      [SGNotifications postNewContent];
    }
    
  };
  
  [_que addOperation:_currentBlogItemsGetter];
  
}


- (void) application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
  
  SGBlogEntriesViewController *vc = [SGBlogEntriesViewController sharedInstance];
  
  if(vc)
  {
    [vc loadLatestFeedData:^(BOOL newData, NSError* error)
     {
       if(error)
       {
         completionHandler(UIBackgroundFetchResultFailed);
       }
       else
       {
         if(newData)
         {
           completionHandler(UIBackgroundFetchResultNewData);
         }
         else
         {
           completionHandler(UIBackgroundFetchResultNoData);
         }
         
       }
     }];
  }
  else
  {
    completionHandler(UIBackgroundFetchResultFailed);
  }
  
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

#pragma mark -
#pragma mark WatchKit

- (void) application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
  _watchKitFetcher = [[WatchKitFetcher alloc] initWithUserInfo:userInfo reply:reply];
  [_watchKitFetcher processRequest];
}

@end
