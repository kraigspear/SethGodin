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
NSString * const KEY_USE_ICLOUD = @"useICloud";
NSString * const KEY_MOVED_TO_UIDOCUMENT = @"movedToUIDocument";

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
#ifdef DEV_BUILD
    return YES;
#else
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_UPGRADED];
#endif
}

- (void) setIsUpgraded:(BOOL) toValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:toValue forKey:KEY_UPGRADED];
    [defaults synchronize];
}

- (void) setUseICloud:(BOOL) toValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:toValue forKey:KEY_USE_ICLOUD];
    [defaults synchronize];
}

- (BOOL) useICloud
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:KEY_USE_ICLOUD];
}

- (BOOL) movedToUIDocument
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:KEY_MOVED_TO_UIDOCUMENT];
}

- (void) setMovedToUIDocument:(BOOL) toValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:toValue forKey:KEY_MOVED_TO_UIDOCUMENT];
    [defaults synchronize];
}

@end
