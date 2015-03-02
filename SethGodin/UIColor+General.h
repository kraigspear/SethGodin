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
+ (UIColor*) menuBackgroundColor;

- (UIColor*)blendedColorWithFraction: (CGFloat)fraction ofColor: (UIColor*)color2;

+ (UIColor*) menuTitleBarBackgroundColor;
+ (UIColor*) menuTitleBarTextColor;

+ (UIColor*) blogEntryTitleBackgroundColor;
+ (UIColor*) titlebarTextColor;
+ (UIColor*) textColorSelected;

/**
 Color that you see when there is a general message.
 Example. No search resutls.
 */
+ (UIColor*) messageBackgroundColor;

/**
 Color used in the message text, should contrast with messageBackgroundColor
 */
+ (UIColor*) messsageTextColor;

/**
 Color on BlogEntiresView for the top title bar.
 */
+ (UIColor*) blogEntriesTopBarBackgroundColor;

/**
 Color of the Text on the Blog Entires View.
 */
+ (UIColor*) blogEntriesTextColor;

@end
