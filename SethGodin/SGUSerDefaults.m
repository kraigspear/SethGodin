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



- (BOOL) isUpgraded
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_UPGRADED];
}

- (void) setIsUpgraded:(BOOL) toValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:toValue forKey:KEY_UPGRADED];
    [defaults synchronize];
}

@end
