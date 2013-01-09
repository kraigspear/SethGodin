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

+ (UIImage*) backButton
{
    return [UIImage imageWithIdentifier:@"backButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor titlebarTextColor];
                
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



@end
