//
//  NSFileManager+Util.h
//  SethGodin
//
//  Created by Kraig Spear on 11/22/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Util)

/**
 Gets the cache path
 @return Cache path
 */
+ (NSString*) cachePath;

/**
 Gets a file name stored in the cache path.
 @return File stored in the cache path
 */
+ (NSString*) cachePathWithFile:(NSString*) inFileName;

@end
