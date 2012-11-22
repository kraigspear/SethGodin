//
//  NSFileManager+Util.m
//  SethGodin
//
//  Created by Kraig Spear on 11/22/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "NSFileManager+Util.h"

@implementation NSFileManager (Util)

+ (NSString*) cachePath
{
    NSArray *documentDirectories =
	NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [documentDirectories objectAtIndex:0];
}

+ (NSString*) cachePathWithFile:(NSString*) inFileName
{
    return [[NSFileManager cachePath] stringByAppendingPathComponent:inFileName];
}

@end
