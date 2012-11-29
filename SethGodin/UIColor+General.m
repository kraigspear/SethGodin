//
//  UIColor+General.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIColor+General.h"

@implementation UIColor (General)

+ (UIColor*) firstButtonColor
{
    static UIColor *firstColor;
    if(firstColor) return firstColor;
    firstColor = [UIColor colorWithHexString:@"b2a589"];
    return firstColor;
}

+ (UIColor*) secondButtonColor
{
    static UIColor *secondColor;
    if(secondColor) return secondColor;
    secondColor = [UIColor colorWithHexString:@"c1b69e"];
    return secondColor;
}

+ (UIColor*) thirdButtonColor
{
    static UIColor *thirdColor;
    if(thirdColor) return thirdColor;
    thirdColor = [UIColor colorWithHexString:@"d1c8b4"];
    return thirdColor;
}

+ (UIColor*) titlebarBackgroundColor
{
    UIColor* yellow =  [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
    UIColor* bgColor = [yellow colorWithAlphaComponent: 0.03];
    return bgColor;
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
