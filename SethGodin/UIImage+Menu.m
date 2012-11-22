//
//  UIImage+Menu.m
//  SethGodin
//
//  Created by Kraig Spear on 11/12/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIImage+Menu.h"
#import "UIImage+BBlock.h"

@implementation UIImage (Menu)


+ (UIImage*) backgroundImageForSize:(CGSize) inSize
{
    return [UIImage imageWithIdentifier:@"backgroundImage" forSize:inSize andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                
                //// Frames
                CGRect frame = CGRectMake(0, 0, 320, 508);
                
                
                //// bgRect Drawing
                UIBezierPath* bgRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.00000 + 0.5), floor(CGRectGetWidth(frame) * 1.00000 + 0.5) - floor(CGRectGetWidth(frame) * 0.00000 + 0.5), floor(CGRectGetHeight(frame) * 1.00000 + 0.5) - floor(CGRectGetHeight(frame) * 0.00000 + 0.5))];
                [yellow setFill];
                [bgRectPath fill];
            }];
}


+ (UIImage*) menuImageWithText:(NSString*) menuText isUpgrade:(BOOL) inIsUpgrade
{
    NSString *menuID = [NSString stringWithFormat:@"menuImageWithText%@%d", menuText, inIsUpgrade];
    return [UIImage imageWithIdentifier:menuID forSize:CGSizeMake(320, 84) andDrawingBlock:^
            {
                
                //// Abstracted Attributes
                NSString* titleTextContent = menuText;
                NSString* upgradeTextContent = @" (upgrade)";
                
                
                //// titleText Drawing
                CGRect titleTextRect = CGRectMake(18, 0, 291, 84);
                [[UIColor whiteColor] setFill];
                [titleTextContent drawInRect: titleTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Bold" size: 32] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentLeft];
                
                
                //// upgradeText Drawing
                if(inIsUpgrade)
                {
                    CGRect upgradeTextRect = CGRectMake(191, 4, 142, 97);
                    [[UIColor whiteColor] setFill];
                    [upgradeTextContent drawInRect: upgradeTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: [UIFont buttonFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentLeft];
                }
            }];
}

+ (UIImage*) alreadyUpgraded
{
    return [UIImage imageWithIdentifier:@"alreadyUpgraded" forSize:CGSizeMake(320, 44) andDrawingBlock:^
            {
                
                //// Abstracted Attributes
                NSString* buttonTextContent = @"Already Upgraded?";
                
                
                //// buttonText Drawing
                CGRect buttonTextRect = CGRectMake(0, 0, 320, 44);
                [[UIColor whiteColor] setFill];
                [buttonTextContent drawInRect: buttonTextRect withFont: [UIFont fontWithName: @"HelveticaNeue" size: [UIFont buttonFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                

            }];
}


@end
