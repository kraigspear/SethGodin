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
  SGCurrentBlogItemsGetter *_currentBlogItemsGetter;
  NSOperationQueue *_watchQue;
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
//  
//  [self fetchLatestCount:7 sendingTo:^(NSDictionary *dictionary)
//   {
//     NSLog(@"dictionary %@", dictionary);
//   }];
  
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
 
  NSLog(@"inside handleWatchKitExtensionRequest");
  
  NSString *fetch = userInfo[@"fetch"];
  
  NSNumber *fetchNumber = userInfo[@"numberToFetch"];
  NSUInteger numberToFetch = [fetchNumber unsignedIntegerValue];
  
  if ([fetch isEqualToString:@"latest"])
  {
    [self fetchLatestCount:numberToFetch sendingTo:reply];
  }
  else
  {
    reply(nil);
  }
}

/**
 *  Fetch the latest content.
 *
 *  @param count  The number of results to return.
 *  @param sendTo Block to call with the results.
 */
- (void) fetchLatestCount:(NSUInteger) count  sendingTo:(void (^)(NSDictionary *)) sendTo
{
  NSAssert(sendTo != nil, @"Don't have anywhere to send the results");
  
  __weak typeof(self) weakSelf = self;
  
  if(_currentBlogItemsGetter)
  {
    NSLog(@"had previous getter");
    [_currentBlogItemsGetter cancel];
  }
  
  if(!_watchQue)
  {
    _watchQue = [[NSOperationQueue alloc] init];
    _watchQue.name = @"watchQue";
  }
  
  UIBackgroundTaskIdentifier *backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithName:@"fetchLatest" expirationHandler:^{
    
    typeof(self) strongSelf = weakSelf;
    
    if(strongSelf)
    {
      NSLog(@"had to cancel");
      [strongSelf->_currentBlogItemsGetter cancel];
      strongSelf->_currentBlogItemsGetter = nil;
      strongSelf->_watchQue = nil;
      sendTo(nil);
    }
    
  }];
  
  _currentBlogItemsGetter = [[SGCurrentBlogItemsGetter alloc] init];
  
  _currentBlogItemsGetter.completionBlock = ^
  {
    NSLog(@"currnet blog items getter completed");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
      typeof(self) strongSelf = weakSelf;
      
      if(strongSelf->_currentBlogItemsGetter.error)
      {
         NSLog(@"error from blog items getter");
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                          NSDictionary *errorDict = @{@"Error" : strongSelf->_currentBlogItemsGetter.error};
                          sendTo(errorDict);
                          [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
                        });
      }
      else
      {
        NSArray *feedItems = strongSelf->_currentBlogItemsGetter.blogEntries;
        
        if (feedItems)
        {
           NSLog(@"we have %ld items from the call", feedItems.count);
          //We will either return the requested amount, or what comes back if it's less than the requested amount
          //If we didn't get anything back we will return an empty array. This could be an error condition
          //but the purpose of this code is to return to an Apple Watch where showing an error doesn't make
          //much sence.
          if (feedItems.count >= count)
          {
            NSLog(@"getting a subset of the results");
            NSRange range = NSMakeRange(0, count);
            NSArray *results = [feedItems subarrayWithRange:range];
            NSArray *dictArray = [strongSelf feedItemsToDictionary:results];
            NSDictionary *ressultsDict = @{@"results" : dictArray};
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                             sendTo(ressultsDict);
                             [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
                           });
          }
          else if(feedItems.count >= 1)
          {
            NSArray *dictArray = [strongSelf feedItemsToDictionary:feedItems];
            NSDictionary *resultsdict = @{@"results" : dictArray};
            
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                             sendTo(resultsdict);
                             [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
                           });
          }
        }
        else
        {
          NSLog(@"we didn't get anything back for feed items");
          NSDictionary *resultsdict = @{@"results" : [NSArray array], @"bullshit" : @"true"};
          dispatch_async(dispatch_get_main_queue(), ^
                         {
                           sendTo(resultsdict);
                           [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
                         });
        }
      }
      
      self->_currentBlogItemsGetter = nil;
    });
  };
  
  [_watchQue addOperation:_currentBlogItemsGetter];
  
}

/**
 *  A dictionary containing the objects of interest to a WatchKit call
 *
 *  @param feedItem Feed item to convert
 *
 *  @return The converted dictionary
 */
- (NSArray*) feedItemsToDictionary:(NSArray*) feedItems
{
  NSMutableArray *feedArray = [NSMutableArray arrayWithCapacity:feedItems.count];
  
  for (SGBlogEntry *blogEntry in feedItems)
  {
    NSDictionary *blogDictionary =
    @{@"title" : blogEntry.title,
      @"summary" : blogEntry.summary,
      @"datePublished" : blogEntry.datePublished,
      @"itemId" : blogEntry.itemID,
      @"content" : blogEntry.content,
      @"urlStr" : blogEntry.urlStr};
    
    [feedArray addObject:blogDictionary];
  }
  
  return feedArray;
}


@end
