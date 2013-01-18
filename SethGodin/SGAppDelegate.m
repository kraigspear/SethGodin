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
#import "SGNotifications.h"
#import "Favorite.h"
#import "SGBlogEntry.h"
#import "SWSplashWindow.h"
#import <Parse/Parse.h>

@implementation SGAppDelegate
{
@private
    NSDateFormatter *_dateformatter;
    SWSplashWindow  *_splashWindow;
}

- (NSDateFormatter*) dateFormatterLongStyle
{
    return _dateformatter;
}

+ (SGAppDelegate*) instance
{
    return (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Flurry startSession:@"5Y7GYTZD4NPMH2N35DPT"];
    [Crittercism enableWithAppID:@"50c92afd63d95269e3000002"];
    
    [Parse setApplicationId:@"k2eo7GeSve5neSkhTFcMLPtIViPicZwLf3opy9bu"
                  clientKey:@"c46oSNaIeVXYVONk0D9wPVxYfBrdZZu0K8Od95wN"];
    
    
    PFUser *currentUser = [PFUser currentUser];
    
    if(!currentUser)
    {
        [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
            if (error)
            {
                NSLog(@"Anonymous login failed.");
            }
            else
            {
                NSLog(@"Anonymous user logged in.");
            }
        }];
    }
    
    if([NSFileManager isICloudEnabled])
    {
        _splashWindow = [[SWSplashWindow alloc] init];
        [_splashWindow showSplash];
        _isICloudSetup = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            [MagicalRecord setupCoreDataStackWithiCloudContainer:@"BLXEQ8692X.com.andersonspear.sethsgodinsblog" contentNameKey:@"favorites" localStoreNamed:@"seth_local" cloudStorePathComponent:@"coredata" completion:^
             {
                 NSLog(@"icloud setup complete!!!!");
                 [self willChangeValueForKey:@"isICloudSetup"];
                 _isICloudSetup = NO;
                 [self didChangeValueForKey:@"isICloudSetup"];
                 
                 [self hideSplash];
                 
                 int64_t delayInSeconds = 5.0;
                 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                 dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                                {
                                    [self exportFavoritesToCoreData];
                                });
                 
             }];

        });
    }
    else
    {
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"SethGodin.sqllite"];
    }
    
    _dateformatter           = [[NSDateFormatter alloc] init];
    _dateformatter.dateStyle =  NSDateFormatterLongStyle;
    
    [SGInAppPurchase sharedInstance];
    
    
    return YES;
}

- (void) exportFavoritesToCoreData
{
    if(self.isICloudSetup) return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
               {
                   NSLog(@"exporing to iCloud");
                   NSArray *favoritesToExport = [[SGFavorites sharedInstance] favorites];
                   
                   if(favoritesToExport.count > 0)
                   {
                       NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
                       
                       for(SGBlogEntry *oldFavorite in favoritesToExport)
                       {
                           Favorite *favorite = [Favorite MR_createInContext:localContext];
                           favorite.content = oldFavorite.content;
                           favorite.date = oldFavorite.datePublished;
                           favorite.favoriteID = oldFavorite.itemID;
                           favorite.summary = oldFavorite.summary;
                           favorite.title = oldFavorite.title;
                           favorite.url = oldFavorite.urlStr;
                           NSLog(@"new favorite created");
                       }
                       
                       [localContext MR_saveNestedContextsErrorHandler:^(NSError *inError)
                        {
                            NSLog(@"Error moving favorites to CoreData %@ %@", inError, inError.userInfo);
                            [Flurry logError:@"CoreDataMoveError" message:@"Error moving favorites to CoreData" error:inError];
                        } completion:^
                        {
                            [[SGFavorites sharedInstance] resetFavorites];
                            NSLog(@"iCloud export complete with no errors");
                            [Flurry logEvent:@"MovedToCoreData"];
                            [[SGUserDefaults sharedInstance] setMovedToCoreData:YES];
                        }];
                   }
               });
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
    [self exportFavoritesToCoreData];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
}


- (void) hideSplash
{
    [_splashWindow hideSplash];
    _splashWindow = nil;
}


@end
