//
//  UIColor+General.h
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (General)

+ (UIColor*) itemsBackgroundColor;
+ (UIColor*) colorWithHexString:(NSString *)stringToConvert;
+ (UIColor*) titlebarBackgroundColor;
+ (UIColor*) tableCellBackgroundColor;


+ (UIColor*) titlebarTextColor;
+ (UIColor*) textColorSelected;

@end
