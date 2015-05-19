//
//  SGUSerDefaults.m
//  SethGodin
//
//  Created by Kraig Spear on 11/21/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGUserDefaults.h"

@implementation SGUserDefaults

NSString * const KEY_UPGRADED = @"upgraded";
NSString * const KEY_ASKED_CLOUD = @"askedToUseCloud";
NSString * const KEY_MOVED_TO_CLOUD = @"movedToCloud";
NSString * const KEY_LAST_PURCHASE_ITEM_FETCH = @"lastPurchaseItemsFetch";

+ (SGUserDefaults*) sharedInstance
{
    static SGUserDefaults *instance;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      instance = [[SGUserDefaults alloc] init];
                  });
    
    return instance;
}

- (id) init
{
    self = [super init];
    
    if(self)
    {
       [self loadDefaults]; 
    }
    
    return self;
}

- (void) loadDefaults
{
    NSString *defaultsPaths = [[NSBundle mainBundle] pathForResource:@"userDefaults.plist" ofType:nil];
    NSDictionary *defaultsDict = [NSDictionary dictionaryWithContentsOfFile:defaultsPaths];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsDict];
}

- (BOOL) isUpgraded
{
    return YES;
#if TARGET_IPHONE_SIMULATOR
    return YES;
#else
   // return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_UPGRADED];
#endif
}

- (void) setIsUpgraded:(BOOL) toValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:toValue forKey:KEY_UPGRADED];
    [defaults synchronize];
}

- (BOOL) wasAskedToUseCloud
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_ASKED_CLOUD];
}

- (void) setWasAskedToUseCloud:(BOOL) toValue
{
    [[NSUserDefaults standardUserDefaults] setBool:toValue forKey:KEY_ASKED_CLOUD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) wasMovedToCloud
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_MOVED_TO_CLOUD];
}

- (void) setWasMovedToCloud:(BOOL) toValue
{
    [[NSUserDefaults standardUserDefaults] setBool:toValue forKey:KEY_MOVED_TO_CLOUD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate*) lastPurchaseItemsFetch
{
  NSDate *lastFetch = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_LAST_PURCHASE_ITEM_FETCH];
  
  if(!lastFetch)
  {
    lastFetch = [NSDate distantPast];
  }
  
  return lastFetch;
}

- (void) setLastPurchaseItemsFetch:(NSDate*) date
{
  [[NSUserDefaults standardUserDefaults] setObject:date forKey:KEY_LAST_PURCHASE_ITEM_FETCH];
}



@end
