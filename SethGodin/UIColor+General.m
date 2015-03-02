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
    return [UIColor colorWithRed:0.980 green:0.851 blue:0.110 alpha:1];
}

+ (UIColor*) tableCellBackgroundColor
{
    return [UIColor colorWithRed:1.000 green:0.600 blue:0.000 alpha:1];
}

+ (UIColor*) blogEntryTitleBackgroundColor
{
    if(IS_IPAD)
        return [UIColor blackColor];
    else
        return [UIColor tableCellBackgroundColor];
}

+ (UIColor*) itemsBackgroundColor
{
    return [UIColor colorWithHexString:@"fff9db"];
}

+ (UIColor*) textColorSelected
{
    return [UIColor colorWithRed:0.976 green:0.820 blue:0.227 alpha:1];
}

+ (UIColor*) menuTitleBarTextColor
{
    return [UIColor colorWithRed:0.980 green:0.851 blue:0.110 alpha:1];
}

+ (UIColor*) titlebarTextColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor*) menuTitleBarBackgroundColor
{
    return [UIColor colorWithRed:1.000 green:0.992 blue:0.976 alpha:1];
}

+ (UIColor*) menuBackgroundColor
{
    return [UIColor colorWithRed:0.980 green:0.851 blue:0.118 alpha:1];
}

+ (UIColor*) blogEntriesTopBarBackgroundColor
{
    return [UIColor colorWithRed:0.980 green:0.851 blue:0.118 alpha:1];
}

+ (UIColor*) blogEntriesTextColor
{
    return [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
}

+ (UIColor*) messageBackgroundColor
{
    return [UIColor colorWithRed:0.678 green:0.796 blue:0.365 alpha:1];
}

+ (UIColor*) messsageTextColor
{
    return [UIColor whiteColor];
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

//From PaintCode
- (UIColor*)blendedColorWithFraction: (CGFloat)fraction ofColor: (UIColor*)color2
{
    UIColor* color1 = self;
    
    CGFloat r1 = 0, g1 = 0, b1 = 0, a1 = 0;
    CGFloat r2 = 0, g2 = 0, b2 = 0, a2 = 0;
    
    
    [color1 getRed: &r1 green: &g1 blue: &b1 alpha: &a1];
    [color2 getRed: &r2 green: &g2 blue: &b2 alpha: &a2];
    
    CGFloat r = r1 * (1 - fraction) + r2 * fraction;
    CGFloat g = g1 * (1 - fraction) + g2 * fraction;
    CGFloat b = b1 * (1 - fraction) + b2 * fraction;
    CGFloat a = a1 * (1 - fraction) + a2 * fraction;
    
    return [UIColor colorWithRed: r green: g blue: b alpha: a];
}

@end
