//
//  NSDictionary-Expanded.h
//  WeatherTest
//
//  Created by Kraig Spear on 3/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary(Expanded) 

- (BOOL) containsKey:(NSString*) key;
- (NSInteger) intForKey:(NSString*) inKey;
- (CGFloat) floatForKey:(NSString*) inKey;

@end
