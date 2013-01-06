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
    
    
    if([NSFileManager isICloudEnabled])
    {
        [MagicalRecord setupCoreDataStackWithiCloudContainer:@"BLXEQ8692X.com.andersonspear.sethsgodinsblog" localStoreNamed:@"sethfavorites"];
        
        
        __block id iCloudSetupObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kMagicalRecordPSCDidCompleteiCloudSetupNotification object:nil queue:nil usingBlock:^(NSNotification *note)
        {
            
            [[NSNotificationCenter defaultCenter] removeObserver:iCloudSetupObserver];
            iCloudSetupObserver = nil;
            
            if(![[SGUserDefaults sharedInstance] movedToCoreData])
            {
                int64_t delayInSeconds = 10.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                               {
                                   [self exportFavoritesToCoreData];
                               });
            }
        }];
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
    if([[SGUserDefaults sharedInstance] movedToCoreData]) return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSLog(@"exporing to iCloud");
                       NSArray *favoritesToExport = [[SGFavorites sharedInstance] favorites];
                       
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
                           NSLog(@"iCloud export complete with no errors");
                           [Flurry logEvent:@"MovedToCoreData"];
                           [[SGUserDefaults sharedInstance] setMovedToCoreData:YES];
                       }];
                       
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
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
