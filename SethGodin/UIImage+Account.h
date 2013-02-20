//
//  UIImage+Account.h
//  SethGodin
//
//  Created by Kraig Spear on 1/31/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Account)

+ (UIImage*) backgroundImageiPadForUserSignedIn:(NSString*) signedIn;

+ (UIImage*) backgroundImageForUserSignedIn:(NSString*) signedIn atOrientation:(UIInterfaceOrientation) orientation;

+ (UIImage*) buttonImageWithTitle:(NSString*) title atSize:(CGSize) inSize;
+ (UIImage*) buttonImageWithTitleLandscape:(NSString *)title atSize:(CGSize)inSize;

@end
