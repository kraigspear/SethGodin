//
//  NSDictionary-Expanded.m
//  WeatherTest
//
//  Created by Kraig Spear on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary-Expanded.h"


@implementation NSDictionary(Expanded)

- (BOOL) containsKey:(NSString*) key
{
	return [[self allKeys] containsObject:key];
}

- (BOOL) isValidForConversion:(NSString*) inStr
{
    if(!inStr) return NO;
    if(inStr == (id) [NSNull null]) return NO;
    return YES;
}

- (CGFloat) floatForKey:(NSString*) inKey
{
    NSString *str = [self objectForKey:inKey];
    
    if(![self isValidForConversion:str]) return 0;
    
    return str.floatValue;
}

- (NSInteger) intForKey:(NSString*) inKey
{
    NSString *str = [self objectForKey:inKey];
    if(![self isValidForConversion:str]) return 0;
    return str.intValue;
}


@end
