//
//  UIColor+General.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIColor+General.h"

@implementation UIColor (General)


+ (UIColor*) titlebarBackgroundColor
{
    return [UIColor colorWithRed:1.000 green:0.812 blue:0.000 alpha:1];
}

+ (UIColor*) tableCellBackgroundColor
{
    return [UIColor colorWithRed:1.000 green:0.600 blue:0.000 alpha:1];
}

+ (UIColor*) itemsBackgroundColor
{
    return [UIColor colorWithHexString:@"fff9db"];
}



+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}
@end
