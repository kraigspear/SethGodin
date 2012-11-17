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
    return [UIColor colorWithRed: 0.751 green: 0.703 blue: 0.608 alpha: 1];
}

+ (UIColor*) secondButtonColor
{
    UIColor *buttonColor = [UIColor firstButtonColor];
    return [buttonColor colorWithAlphaComponent: 0.8];
}

+ (UIColor*) thirdButtonColor
{
    UIColor *buttonColor = [UIColor firstButtonColor];
    return [buttonColor colorWithAlphaComponent: 0.6];
}



@end
