//
//  UIImage+Buttons.m
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIImage+General.h"
#import "UIImage+BBlock.h"
#import "UIColor+General.h"

@implementation UIImage (General)

+ (UIImage*) backButtonWithColor:(UIColor*) inColor
{
    CGFloat r, g, b, a;
    [inColor getRed:&r green:&g blue:&b alpha:&a];
    
    NSString *identifier = [NSString stringWithFormat:@"backButton%f%f%f%f", r, g, b, a];
    
    return [UIImage imageWithIdentifier:identifier forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = inColor;
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
                [bezier3Path moveToPoint: CGPointMake(34.71, 26.22)];
                [bezier3Path addLineToPoint: CGPointMake(18.16, 26.22)];
                [bezier3Path addLineToPoint: CGPointMake(21.99, 29.73)];
                [bezier3Path addCurveToPoint: CGPointMake(21.99, 33.56) controlPoint1: CGPointMake(23.15, 30.78) controlPoint2: CGPointMake(23.15, 32.5)];
                [bezier3Path addCurveToPoint: CGPointMake(19.9, 34.36) controlPoint1: CGPointMake(21.41, 34.09) controlPoint2: CGPointMake(20.66, 34.36)];
                [bezier3Path addCurveToPoint: CGPointMake(17.8, 33.56) controlPoint1: CGPointMake(19.14, 34.36) controlPoint2: CGPointMake(18.38, 34.09)];
                [bezier3Path addLineToPoint: CGPointMake(8.92, 25.42)];
                [bezier3Path addCurveToPoint: CGPointMake(8.55, 25.01) controlPoint1: CGPointMake(8.78, 25.3) controlPoint2: CGPointMake(8.66, 25.16)];
                [bezier3Path addCurveToPoint: CGPointMake(8.42, 24.8) controlPoint1: CGPointMake(8.5, 24.94) controlPoint2: CGPointMake(8.47, 24.87)];
                [bezier3Path addCurveToPoint: CGPointMake(8.27, 24.54) controlPoint1: CGPointMake(8.37, 24.72) controlPoint2: CGPointMake(8.32, 24.63)];
                [bezier3Path addCurveToPoint: CGPointMake(8.18, 24.27) controlPoint1: CGPointMake(8.24, 24.45) controlPoint2: CGPointMake(8.21, 24.36)];
                [bezier3Path addCurveToPoint: CGPointMake(8.11, 24.04) controlPoint1: CGPointMake(8.16, 24.19) controlPoint2: CGPointMake(8.12, 24.12)];
                [bezier3Path addCurveToPoint: CGPointMake(8.11, 22.97) controlPoint1: CGPointMake(8.03, 23.69) controlPoint2: CGPointMake(8.03, 23.32)];
                [bezier3Path addCurveToPoint: CGPointMake(8.18, 22.74) controlPoint1: CGPointMake(8.12, 22.89) controlPoint2: CGPointMake(8.16, 22.82)];
                [bezier3Path addCurveToPoint: CGPointMake(8.27, 22.47) controlPoint1: CGPointMake(8.21, 22.65) controlPoint2: CGPointMake(8.24, 22.56)];
                [bezier3Path addCurveToPoint: CGPointMake(8.42, 22.21) controlPoint1: CGPointMake(8.32, 22.38) controlPoint2: CGPointMake(8.37, 22.29)];
                [bezier3Path addCurveToPoint: CGPointMake(8.55, 22) controlPoint1: CGPointMake(8.47, 22.14) controlPoint2: CGPointMake(8.5, 22.07)];
                [bezier3Path addCurveToPoint: CGPointMake(8.92, 21.59) controlPoint1: CGPointMake(8.66, 21.85) controlPoint2: CGPointMake(8.78, 21.71)];
                [bezier3Path addLineToPoint: CGPointMake(17.8, 13.45)];
                [bezier3Path addCurveToPoint: CGPointMake(21.99, 13.45) controlPoint1: CGPointMake(18.96, 12.39) controlPoint2: CGPointMake(20.83, 12.39)];
                [bezier3Path addCurveToPoint: CGPointMake(21.99, 17.28) controlPoint1: CGPointMake(23.15, 14.51) controlPoint2: CGPointMake(23.15, 16.23)];
                [bezier3Path addLineToPoint: CGPointMake(18.16, 20.79)];
                [bezier3Path addLineToPoint: CGPointMake(34.71, 20.79)];
                [bezier3Path addCurveToPoint: CGPointMake(37.67, 23.51) controlPoint1: CGPointMake(36.35, 20.79) controlPoint2: CGPointMake(37.67, 22.01)];
                [bezier3Path addCurveToPoint: CGPointMake(34.71, 26.22) controlPoint1: CGPointMake(37.67, 25) controlPoint2: CGPointMake(36.35, 26.22)];
                [bezier3Path closePath];
                [yellow setFill];
                [bezier3Path fill];
                
                
                
            }];
    
}

+ (UIImage*) closeButtonWithColor:(UIColor*) inColor
{
    CGFloat r, g, b, a;
    [inColor getRed:&r green:&g blue:&b alpha:&a];
    
    NSString *identifier = [NSString stringWithFormat:@"closeButton%f%f%f%f", r, g, b, a];
    
    return [UIImage imageWithIdentifier:identifier forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = inColor;
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint: CGPointMake(34.25, 10.43)];
                [bezier2Path addCurveToPoint: CGPointMake(28.84, 10.43) controlPoint1: CGPointMake(32.75, 8.82) controlPoint2: CGPointMake(30.33, 8.82)];
                [bezier2Path addLineToPoint: CGPointMake(22.37, 17.4)];
                [bezier2Path addLineToPoint: CGPointMake(15.9, 10.43)];
                [bezier2Path addCurveToPoint: CGPointMake(10.5, 10.43) controlPoint1: CGPointMake(14.41, 8.82) controlPoint2: CGPointMake(11.99, 8.82)];
                [bezier2Path addCurveToPoint: CGPointMake(10.5, 16.25) controlPoint1: CGPointMake(9.01, 12.04) controlPoint2: CGPointMake(9.01, 14.64)];
                [bezier2Path addLineToPoint: CGPointMake(16.97, 23.22)];
                [bezier2Path addLineToPoint: CGPointMake(10.5, 30.18)];
                [bezier2Path addCurveToPoint: CGPointMake(10.5, 36) controlPoint1: CGPointMake(9.01, 31.79) controlPoint2: CGPointMake(9.01, 34.39)];
                [bezier2Path addCurveToPoint: CGPointMake(13.2, 37.21) controlPoint1: CGPointMake(11.25, 36.81) controlPoint2: CGPointMake(12.22, 37.21)];
                [bezier2Path addCurveToPoint: CGPointMake(15.9, 36) controlPoint1: CGPointMake(14.18, 37.21) controlPoint2: CGPointMake(15.16, 36.81)];
                [bezier2Path addLineToPoint: CGPointMake(22.37, 29.04)];
                [bezier2Path addLineToPoint: CGPointMake(28.84, 36)];
                [bezier2Path addCurveToPoint: CGPointMake(31.54, 37.21) controlPoint1: CGPointMake(29.59, 36.81) controlPoint2: CGPointMake(30.56, 37.21)];
                [bezier2Path addCurveToPoint: CGPointMake(34.25, 36) controlPoint1: CGPointMake(32.52, 37.21) controlPoint2: CGPointMake(33.5, 36.81)];
                [bezier2Path addCurveToPoint: CGPointMake(34.25, 30.18) controlPoint1: CGPointMake(35.74, 34.39) controlPoint2: CGPointMake(35.74, 31.79)];
                [bezier2Path addLineToPoint: CGPointMake(27.78, 23.22)];
                [bezier2Path addLineToPoint: CGPointMake(34.25, 16.25)];
                [bezier2Path addCurveToPoint: CGPointMake(34.25, 10.43) controlPoint1: CGPointMake(35.74, 14.64) controlPoint2: CGPointMake(35.74, 12.04)];
                [bezier2Path closePath];
                [yellow setFill];
                [bezier2Path fill];
            }];

}

+ (UIImage*) closeButton
{
    return [UIImage imageWithIdentifier:@"closeButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor titlebarTextColor];
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint: CGPointMake(34.25, 10.43)];
                [bezier2Path addCurveToPoint: CGPointMake(28.84, 10.43) controlPoint1: CGPointMake(32.75, 8.82) controlPoint2: CGPointMake(30.33, 8.82)];
                [bezier2Path addLineToPoint: CGPointMake(22.37, 17.4)];
                [bezier2Path addLineToPoint: CGPointMake(15.9, 10.43)];
                [bezier2Path addCurveToPoint: CGPointMake(10.5, 10.43) controlPoint1: CGPointMake(14.41, 8.82) controlPoint2: CGPointMake(11.99, 8.82)];
                [bezier2Path addCurveToPoint: CGPointMake(10.5, 16.25) controlPoint1: CGPointMake(9.01, 12.04) controlPoint2: CGPointMake(9.01, 14.64)];
                [bezier2Path addLineToPoint: CGPointMake(16.97, 23.22)];
                [bezier2Path addLineToPoint: CGPointMake(10.5, 30.18)];
                [bezier2Path addCurveToPoint: CGPointMake(10.5, 36) controlPoint1: CGPointMake(9.01, 31.79) controlPoint2: CGPointMake(9.01, 34.39)];
                [bezier2Path addCurveToPoint: CGPointMake(13.2, 37.21) controlPoint1: CGPointMake(11.25, 36.81) controlPoint2: CGPointMake(12.22, 37.21)];
                [bezier2Path addCurveToPoint: CGPointMake(15.9, 36) controlPoint1: CGPointMake(14.18, 37.21) controlPoint2: CGPointMake(15.16, 36.81)];
                [bezier2Path addLineToPoint: CGPointMake(22.37, 29.04)];
                [bezier2Path addLineToPoint: CGPointMake(28.84, 36)];
                [bezier2Path addCurveToPoint: CGPointMake(31.54, 37.21) controlPoint1: CGPointMake(29.59, 36.81) controlPoint2: CGPointMake(30.56, 37.21)];
                [bezier2Path addCurveToPoint: CGPointMake(34.25, 36) controlPoint1: CGPointMake(32.52, 37.21) controlPoint2: CGPointMake(33.5, 36.81)];
                [bezier2Path addCurveToPoint: CGPointMake(34.25, 30.18) controlPoint1: CGPointMake(35.74, 34.39) controlPoint2: CGPointMake(35.74, 31.79)];
                [bezier2Path addLineToPoint: CGPointMake(27.78, 23.22)];
                [bezier2Path addLineToPoint: CGPointMake(34.25, 16.25)];
                [bezier2Path addCurveToPoint: CGPointMake(34.25, 10.43) controlPoint1: CGPointMake(35.74, 14.64) controlPoint2: CGPointMake(35.74, 12.04)];
                [bezier2Path closePath];
                [yellow setFill];
                [bezier2Path fill];
            }];
}

+ (UIImage*) defaultTitleBarImage
{
    return [UIImage titleBarWithTitle:@"SETH GODIN"];
}

+ (UIImage*) titleBarWithTitle:(NSString*) inTitle
{
    return [self titleBarWithTitle:inTitle usingBackgroundColor:[UIColor titlebarBackgroundColor]];
}


+ (UIImage*) titleBarWithTitle:(NSString*) inTitle usingBackgroundColor:(UIColor*) inColor
{
    
    float r, g, b, a;
    
    [inColor getRed:&r green:&g blue:&b alpha:&a];
    
    NSString *identifier = [NSString stringWithFormat:@"titleBarWithTitleColor%@%f%f%f%f", inTitle, r, g, b, a];
    
    return [UIImage imageWithIdentifier:identifier forSize:CGSizeMake(320,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor whiteColor];
                UIColor* bgColor = inColor;
                
                //// Abstracted Attributes
                NSString* titleTextContent = inTitle;
                
                //// bgRect Drawing
                UIBezierPath* bgRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 44)];
                [bgColor setFill];
                [bgRectPath fill];
                
                
                //// titleText Drawing
                CGRect titleTextRect = CGRectMake(0, 7, 320, 30);
                [yellow setFill];
                [titleTextContent drawInRect: titleTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 26] lineBreakMode: NSLineBreakByWordWrapping alignment: UITextAlignmentCenter];
                
                
                
                
                
                
                
                
                
            }];
}

+ (UIImage*) favoritesButton:(BOOL) isSelcted
{
    NSString *identifier = [NSString stringWithFormat:@"favoritesButton%d", isSelcted];
    
    return [UIImage imageWithIdentifier:identifier forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* color0 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
                UIColor* color8 = [color0 colorWithAlphaComponent: 0.3];
                
                //// Bezier 5 Drawing
                UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
                [bezier5Path moveToPoint: CGPointMake(22.39, 35.79)];
                [bezier5Path addCurveToPoint: CGPointMake(28.87, 10) controlPoint1: CGPointMake(46.8, 19.81) controlPoint2: CGPointMake(33.83, 10)];
                [bezier5Path addCurveToPoint: CGPointMake(22.39, 13.81) controlPoint1: CGPointMake(23.91, 10) controlPoint2: CGPointMake(22.39, 13.81)];
                [bezier5Path addCurveToPoint: CGPointMake(15.9, 10) controlPoint1: CGPointMake(22.39, 13.81) controlPoint2: CGPointMake(20.86, 10)];
                [bezier5Path addCurveToPoint: CGPointMake(22.39, 35.79) controlPoint1: CGPointMake(10.94, 10) controlPoint2: CGPointMake(-2.03, 19.81)];
                [bezier5Path closePath];
                
                if(isSelcted)
                {
                    [color0 setFill];
                }
                else
                {
                    [color8 setFill];
                }
                
                [bezier5Path fill];
                
            }];
}

+ (UIImage*) shareButton
{
    return [UIImage imageWithIdentifier:@"shareButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor titlebarTextColor];
                
                //// Group
                {
                    //// Bezier Drawing
                    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(14.57, 21.47)];
                    [bezierPath addCurveToPoint: CGPointMake(16.2, 19.34) controlPoint1: CGPointMake(15, 20.75) controlPoint2: CGPointMake(15.55, 20.04)];
                    [bezierPath addCurveToPoint: CGPointMake(18.57, 17.44) controlPoint1: CGPointMake(16.86, 18.64) controlPoint2: CGPointMake(17.65, 18)];
                    [bezierPath addCurveToPoint: CGPointMake(21.61, 16.03) controlPoint1: CGPointMake(19.49, 16.87) controlPoint2: CGPointMake(20.38, 16.4)];
                    [bezierPath addCurveToPoint: CGPointMake(25.83, 15.35) controlPoint1: CGPointMake(22.84, 15.65) controlPoint2: CGPointMake(24.25, 15.42)];
                    [bezierPath addLineToPoint: CGPointMake(25.83, 9.1)];
                    [bezierPath addLineToPoint: CGPointMake(37.92, 18.75)];
                    [bezierPath addLineToPoint: CGPointMake(25.83, 28.24)];
                    [bezierPath addLineToPoint: CGPointMake(25.83, 21.35)];
                    [bezierPath addCurveToPoint: CGPointMake(24.24, 21.38) controlPoint1: CGPointMake(25.43, 21.35) controlPoint2: CGPointMake(24.9, 21.36)];
                    [bezierPath addCurveToPoint: CGPointMake(22.04, 21.61) controlPoint1: CGPointMake(23.58, 21.41) controlPoint2: CGPointMake(22.85, 21.48)];
                    [bezierPath addCurveToPoint: CGPointMake(19.67, 22.15) controlPoint1: CGPointMake(21.23, 21.73) controlPoint2: CGPointMake(20.56, 21.91)];
                    [bezierPath addCurveToPoint: CGPointMake(17.04, 23.17) controlPoint1: CGPointMake(18.78, 22.4) controlPoint2: CGPointMake(17.9, 22.73)];
                    [bezierPath addCurveToPoint: CGPointMake(14.61, 24.73) controlPoint1: CGPointMake(16.18, 23.6) controlPoint2: CGPointMake(15.37, 24.08)];
                    [bezierPath addCurveToPoint: CGPointMake(12.65, 27.12) controlPoint1: CGPointMake(13.85, 25.38) controlPoint2: CGPointMake(13.2, 26.18)];
                    [bezierPath addCurveToPoint: CGPointMake(14.57, 21.47) controlPoint1: CGPointMake(12.91, 25) controlPoint2: CGPointMake(13.55, 23.16)];
                    [bezierPath closePath];
                    [yellow setFill];
                    [bezierPath fill];
                    
                    
                    //// Bezier 2 Drawing
                    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
                    [bezier2Path moveToPoint: CGPointMake(30.23, 29.21)];
                    [bezier2Path addLineToPoint: CGPointMake(30.23, 31.62)];
                    [bezier2Path addLineToPoint: CGPointMake(9.36, 31.62)];
                    [bezier2Path addLineToPoint: CGPointMake(9.36, 16.99)];
                    [bezier2Path addLineToPoint: CGPointMake(13.27, 16.99)];
                    [bezier2Path addCurveToPoint: CGPointMake(13.82, 15.88) controlPoint1: CGPointMake(13.38, 16.57) controlPoint2: CGPointMake(13.54, 16.18)];
                    [bezier2Path addCurveToPoint: CGPointMake(15.04, 14.73) controlPoint1: CGPointMake(14.19, 15.48) controlPoint2: CGPointMake(14.61, 15.1)];
                    [bezier2Path addLineToPoint: CGPointMake(7.16, 14.73)];
                    [bezier2Path addLineToPoint: CGPointMake(7.16, 33.87)];
                    [bezier2Path addLineToPoint: CGPointMake(32.42, 33.87)];
                    [bezier2Path addLineToPoint: CGPointMake(32.42, 27.62)];
                    [bezier2Path addLineToPoint: CGPointMake(30.23, 29.21)];
                    [bezier2Path closePath];
                    [yellow setFill];
                    [bezier2Path fill];
                }
                
                
                
            }];
}

+ (UIImage*) leftArrow
{
    return [UIImage imageWithIdentifier:@"leftArrow" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Bezier 5 Drawing
                UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
                [bezier5Path moveToPoint: CGPointMake(30, 38.5)];
                [bezier5Path addLineToPoint: CGPointMake(30, 6.5)];
                [bezier5Path addLineToPoint: CGPointMake(7.5, 20.5)];
                [bezier5Path addLineToPoint: CGPointMake(30, 38.5)];
                [bezier5Path closePath];
                [[UIColor whiteColor] setFill];
                [bezier5Path fill];
            }];
}

+ (UIImage*) rightArrow
{
    return [UIImage imageWithIdentifier:@"rightArrow" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                
                //// Bezier Drawing
                UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(12.5, 5.5)];
                [bezierPath addLineToPoint: CGPointMake(12.5, 37.5)];
                [bezierPath addLineToPoint: CGPointMake(35, 23.5)];
                [bezierPath addLineToPoint: CGPointMake(12.5, 5.5)];
                [bezierPath closePath];
                [[UIColor whiteColor] setFill];
                [bezierPath fill];
            }];
}

+ (UIImage*) previousButton
{
    return [UIImage imageWithIdentifier:@"previous" forSize:CGSizeMake(12, 20) andDrawingBlock:^
            {
                
                
                //// Bezier Drawing
                UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(10.5, 1.5)];
                [bezierPath addLineToPoint: CGPointMake(0.5, 10.5)];
                [bezierPath addLineToPoint: CGPointMake(10.5, 19.5)];
                [bezierPath addLineToPoint: CGPointMake(10.5, 1.5)];
                [bezierPath closePath];
                [[UIColor whiteColor] setFill];
                [bezierPath fill];
                
            }];
}

+ (UIImage*) nextButton
{
    return [UIImage imageWithIdentifier:@"next" forSize:CGSizeMake(12, 20) andDrawingBlock:^
            {
                
                
                //// Bezier 2 Drawing
                UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
                [bezier2Path moveToPoint: CGPointMake(0.5, 19.5)];
                [bezier2Path addLineToPoint: CGPointMake(10.5, 10.5)];
                [bezier2Path addLineToPoint: CGPointMake(0.5, 1.5)];
                [bezier2Path addLineToPoint: CGPointMake(0.5, 19.5)];
                [bezier2Path closePath];
                [[UIColor whiteColor] setFill];
                [bezier2Path fill];
            }];
}

+ (UIImage*) popupCloseButton
{
    return [UIImage imageWithIdentifier:@"popupCloseButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* closeBorderColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
                UIColor* closeBackground = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
                
                //// Abstracted Attributes
                NSString* xTextContent = @"X";
                
                
                //// Group
                {
                    //// whiteOval Drawing
                    UIBezierPath* whiteOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(2, 2, 40, 40)];
                    [closeBorderColor setFill];
                    [whiteOvalPath fill];
                    
                    
                    //// blackOval Drawing
                    UIBezierPath* blackOvalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(4, 4, 36, 36)];
                    [closeBackground setFill];
                    [blackOvalPath fill];
                    
                    
                    //// xText Drawing
                    CGRect xTextRect = CGRectMake(4.5, 3, 36, 29);
                    [closeBorderColor setFill];
                    [xTextContent drawInRect: xTextRect withFont: [UIFont fontWithName: @"Helvetica" size: 30] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                }
                
            }];
}

+ (UIImage*) popupBackgroundForSize:(CGSize) inSize color:(UIColor*) inColor identifier:(NSString*) inIdentifer
{
    
    //UIColor* bgColor = inColor;
    //CGRect frame = CGRectMake(0, 0, inSize.width, inSize.height);
    return [UIImage imageWithIdentifier:inIdentifer forSize:inSize andDrawingBlock:^
            {
                //// General Declarations
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Color Declarations
                UIColor* bgColor = inColor;
                CGFloat bgColorRGBA[4];
                [bgColor getRed: &bgColorRGBA[0] green: &bgColorRGBA[1] blue: &bgColorRGBA[2] alpha: &bgColorRGBA[3]];
                
                UIColor* bdrColor = [UIColor colorWithRed: (bgColorRGBA[0] * 0.6 + 0.4) green: (bgColorRGBA[1] * 0.6 + 0.4) blue: (bgColorRGBA[2] * 0.6 + 0.4) alpha: (bgColorRGBA[3] * 0.6 + 0.4)];
                
                //// Shadow Declarations
                UIColor* bgShadow = [UIColor blackColor];
                CGSize bgShadowOffset = CGSizeMake(2.1, 2.1);
                CGFloat bgShadowBlurRadius = 4;
                
                //// Frames
                CGRect frame = CGRectMake(0, 0, inSize.width, inSize.height);
                
                
                //// backRect Drawing
                UIBezierPath* backRectPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.03125 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.04583 + 0.5), floor(CGRectGetWidth(frame) * 0.97031) - floor(CGRectGetWidth(frame) * 0.03125 + 0.5) + 0.5, floor(CGRectGetHeight(frame) * 0.95417 + 0.5) - floor(CGRectGetHeight(frame) * 0.04583 + 0.5)) cornerRadius: 3];
                CGContextSaveGState(context);
                CGContextSetShadowWithColor(context, bgShadowOffset, bgShadowBlurRadius, bgShadow.CGColor);
                [bgColor setFill];
                [backRectPath fill];
                CGContextRestoreGState(context);
                
                [bdrColor setStroke];
                backRectPath.lineWidth = 1.5;
                [backRectPath stroke];
                
                
                
            }];
}


+ (UIImage*) andersonSpearCloudLogo
{
    
    return [UIImage imageWithIdentifier:@"andersonspearcloudlogo" forSize:CGSizeMake(160, 125) andDrawingBlock:^
            {
                //// General Declarations
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Color Declarations
                UIColor* color0 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
                
                //// Shadow Declarations
                UIColor* shadow = [UIColor darkGrayColor];
                CGSize shadowOffset = CGSizeMake(1.1, 1.1);
                CGFloat shadowBlurRadius = 4;
                
                //// Abstracted Attributes
                NSString* textContent = @"Anderson+";
                NSString* spearTextContent = @"Spear";
                
                
                //// Layer 1
                {
                    //// Bezier Drawing
                    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(137.72, 50.26)];
                    [bezierPath addCurveToPoint: CGPointMake(96.39, 4.26) controlPoint1: CGPointMake(137.43, 24.81) controlPoint2: CGPointMake(119.06, 4.26)];
                    [bezierPath addCurveToPoint: CGPointMake(57.71, 34.59) controlPoint1: CGPointMake(78.66, 4.26) controlPoint2: CGPointMake(63.56, 16.9)];
                    [bezierPath addCurveToPoint: CGPointMake(42.34, 25.76) controlPoint1: CGPointMake(54.23, 29.26) controlPoint2: CGPointMake(48.68, 25.76)];
                    [bezierPath addCurveToPoint: CGPointMake(23.26, 47.25) controlPoint1: CGPointMake(31.81, 25.76) controlPoint2: CGPointMake(23.26, 35.38)];
                    [bezierPath addCurveToPoint: CGPointMake(23.53, 50.12) controlPoint1: CGPointMake(23.26, 48.24) controlPoint2: CGPointMake(23.42, 49.17)];
                    [bezierPath addCurveToPoint: CGPointMake(4.19, 83.08) controlPoint1: CGPointMake(12.16, 55.58) controlPoint2: CGPointMake(4.19, 68.28)];
                    [bezierPath addCurveToPoint: CGPointMake(35.98, 118.9) controlPoint1: CGPointMake(4.19, 102.86) controlPoint2: CGPointMake(18.44, 118.9)];
                    [bezierPath addLineToPoint: CGPointMake(74.14, 118.9)];
                    [bezierPath addLineToPoint: CGPointMake(74.14, 97.41)];
                    [bezierPath addLineToPoint: CGPointMake(61.42, 97.41)];
                    [bezierPath addLineToPoint: CGPointMake(80.5, 68.75)];
                    [bezierPath addLineToPoint: CGPointMake(99.57, 97.41)];
                    [bezierPath addLineToPoint: CGPointMake(86.86, 97.41)];
                    [bezierPath addLineToPoint: CGPointMake(86.86, 118.9)];
                    [bezierPath addLineToPoint: CGPointMake(125.01, 118.9)];
                    [bezierPath addCurveToPoint: CGPointMake(156.81, 83.08) controlPoint1: CGPointMake(142.57, 118.9) controlPoint2: CGPointMake(156.81, 102.86)];
                    [bezierPath addCurveToPoint: CGPointMake(137.72, 50.26) controlPoint1: CGPointMake(156.81, 68.38) controlPoint2: CGPointMake(148.95, 55.79)];
                    [bezierPath closePath];
                    CGContextSaveGState(context);
                    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
                    [color0 setFill];
                    [bezierPath fill];
                    CGContextRestoreGState(context);
                    
                }
                
                
                //// Text Drawing
                CGRect textRect = CGRectMake(30, 33, 106, 30);
                [[UIColor blackColor] setFill];
                [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"HelveticaNeue-Bold" size: [UIFont buttonFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// spearText Drawing
                CGRect spearTextRect = CGRectMake(28, 48.5, 106, 30);
                [[UIColor blackColor] setFill];
                [spearTextContent drawInRect: spearTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Bold" size: [UIFont buttonFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
            }];
    
    
}

+ (UIImage*) settingsButtonImageWithText:(NSString*) inText  size:(CGSize) inSize
{
    NSString *identifier = [NSString stringWithFormat:@"loginButtonWithSize%@%f%f", inText, inSize.width, inSize.height];
    
    return [UIImage imageWithIdentifier:identifier forSize:inSize andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* bgColor = [UIColor colorWithRed: 1 green: 0.606 blue: 0.08 alpha: 1];
                CGFloat bgColorRGBA[4];
                [bgColor getRed: &bgColorRGBA[0] green: &bgColorRGBA[1] blue: &bgColorRGBA[2] alpha: &bgColorRGBA[3]];
                
                UIColor* bdrColor = [UIColor colorWithRed: (bgColorRGBA[0] * 0.9) green: (bgColorRGBA[1] * 0.9) blue: (bgColorRGBA[2] * 0.9) alpha: (bgColorRGBA[3] * 0.9 + 0.1)];
                
                //// Frames
                CGRect frame = CGRectMake(0, 0, inSize.width, inSize.height);
                
                //// Abstracted Attributes
                NSString* titleTextContent = inText;
                
                
                //// buttonRect Drawing
                UIBezierPath* buttonRectPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00503) + 0.5, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 2.5) * 0.00990) + 0.5, floor(CGRectGetWidth(frame) * 0.99497) - floor(CGRectGetWidth(frame) * 0.00503), CGRectGetHeight(frame) - 3 - floor((CGRectGetHeight(frame) - 2.5) * 0.00990)) cornerRadius: 4];
                [bgColor setFill];
                [buttonRectPath fill];
                [bdrColor setStroke];
                buttonRectPath.lineWidth = 1;
                [buttonRectPath stroke];
                
                
                //// titleText Drawing
                CGRect titleTextRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00336 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 34) * 0.36842 + 0.5), floor(CGRectGetWidth(frame) * 0.99329 + 0.5) - floor(CGRectGetWidth(frame) * 0.00336 + 0.5), 34);
                [[UIColor whiteColor] setFill];
                [titleTextContent drawInRect: titleTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 30] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                

                
                

                
                

            }];
}


@end
