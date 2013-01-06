//
//  SGAppDelegate.h
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGAppDelegate : UIResponder <UIApplicationDelegate>

/**
 Main window
 */
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) BOOL isNetworkAvailable;

/**
 A long dateformatter that can be used throughout the App.
 @return NSDateFormatter set to long format
 */
- (NSDateFormatter*) dateFormatterLongStyle;
+ (SGAppDelegate*) instance;

@end
