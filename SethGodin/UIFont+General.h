//
//  UIFont+General.h
//  SethGodin
//
//  Created by Kraig Spear on 1/14/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (General)

/**
 Font for the title view on BlogEntriesView.
 */
+ (UIFont*) blogEntriesTitleFont;

+ (UIFont*) menuButtonFont;

/**
 Font to be used in the title bar.
 */
+ (UIFont*) titleBarTitleFont;

/**
 Font used in message views. Like no search results...
 */
+ (UIFont*) messageTextFont;

@end
