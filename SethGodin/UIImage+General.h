//
//  UIImage+Buttons.h
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (General)

+ (UIImage*) backButton;
+ (UIImage*) titleBarWithTitle:(NSString*) inTitle;
+ (UIImage*) closeButton;
+ (UIImage*) favoritesButton:(BOOL) isSelcted;
+ (UIImage*) shareButton;
+ (UIImage*) leftArrow;
+ (UIImage*) rightArrow;
+ (UIImage*) previousButton;
+ (UIImage*) nextButton;

@end
