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
+ (UIImage*) backgroundImageForUserSignedIn:(NSString*) signedIn;
+ (UIImage*) buttonImageWithTitle:(NSString*) title atSize:(CGSize) inSize;

@end
