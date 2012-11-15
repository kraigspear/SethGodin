//
//  UIImage+Menu.h
//  SethGodin
//
//  Created by Kraig Spear on 11/12/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Menu)

+ (UIImage*) backgroundImageForSize:(CGSize) inSize;
+ (UIImage*) menuImageWithText:(NSString*) menuText isUpgrade:(BOOL) inIsUpgrade;
+ (UIImage*) alreadyUpgraded;

@end
