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
              UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
              
              //// Bezier Drawing
              UIBezierPath* bezierPath = UIBezierPath.bezierPath;
              [bezierPath moveToPoint: CGPointMake(18.56, 11)];
              [bezierPath addCurveToPoint: CGPointMake(19.03, 10.78) controlPoint1: CGPointMake(18.74, 11) controlPoint2: CGPointMake(18.91, 10.92)];
              [bezierPath addLineToPoint: CGPointMake(21.84, 7.56)];
              [bezierPath addLineToPoint: CGPointMake(21.84, 29.75)];
              [bezierPath addCurveToPoint: CGPointMake(22.5, 30.5) controlPoint1: CGPointMake(21.84, 30.16) controlPoint2: CGPointMake(22.14, 30.5)];
              [bezierPath addCurveToPoint: CGPointMake(23.16, 29.75) controlPoint1: CGPointMake(22.86, 30.5) controlPoint2: CGPointMake(23.16, 30.16)];
              [bezierPath addLineToPoint: CGPointMake(23.16, 7.56)];
              [bezierPath addLineToPoint: CGPointMake(25.97, 10.78)];
              [bezierPath addCurveToPoint: CGPointMake(26.44, 11) controlPoint1: CGPointMake(26.09, 10.92) controlPoint2: CGPointMake(26.26, 11)];
              [bezierPath addCurveToPoint: CGPointMake(27.09, 10.25) controlPoint1: CGPointMake(26.8, 11) controlPoint2: CGPointMake(27.09, 10.66)];
              [bezierPath addCurveToPoint: CGPointMake(26.9, 9.72) controlPoint1: CGPointMake(27.09, 10.04) controlPoint2: CGPointMake(27.02, 9.86)];
              [bezierPath addLineToPoint: CGPointMake(22.96, 5.22)];
              [bezierPath addCurveToPoint: CGPointMake(22.5, 5) controlPoint1: CGPointMake(22.85, 5.08) controlPoint2: CGPointMake(22.68, 5)];
              [bezierPath addCurveToPoint: CGPointMake(22.04, 5.22) controlPoint1: CGPointMake(22.32, 5) controlPoint2: CGPointMake(22.15, 5.08)];
              [bezierPath addLineToPoint: CGPointMake(18.1, 9.72)];
              [bezierPath addCurveToPoint: CGPointMake(17.91, 10.25) controlPoint1: CGPointMake(17.98, 9.86) controlPoint2: CGPointMake(17.91, 10.04)];
              [bezierPath addCurveToPoint: CGPointMake(18.56, 11) controlPoint1: CGPointMake(17.91, 10.66) controlPoint2: CGPointMake(18.2, 11)];
              [bezierPath closePath];
              [bezierPath moveToPoint: CGPointMake(31.69, 15.5)];
              [bezierPath addLineToPoint: CGPointMake(26.44, 15.5)];
              [bezierPath addCurveToPoint: CGPointMake(25.78, 16.25) controlPoint1: CGPointMake(26.07, 15.5) controlPoint2: CGPointMake(25.78, 15.84)];
              [bezierPath addCurveToPoint: CGPointMake(26.44, 17) controlPoint1: CGPointMake(25.78, 16.66) controlPoint2: CGPointMake(26.07, 17)];
              [bezierPath addLineToPoint: CGPointMake(31.69, 17)];
              [bezierPath addLineToPoint: CGPointMake(31.69, 36.5)];
              [bezierPath addLineToPoint: CGPointMake(13.31, 36.5)];
              [bezierPath addLineToPoint: CGPointMake(13.31, 17)];
              [bezierPath addLineToPoint: CGPointMake(18.56, 17)];
              [bezierPath addCurveToPoint: CGPointMake(19.22, 16.25) controlPoint1: CGPointMake(18.93, 17) controlPoint2: CGPointMake(19.22, 16.66)];
              [bezierPath addCurveToPoint: CGPointMake(18.56, 15.5) controlPoint1: CGPointMake(19.22, 15.84) controlPoint2: CGPointMake(18.93, 15.5)];
              [bezierPath addLineToPoint: CGPointMake(13.31, 15.5)];
              [bezierPath addCurveToPoint: CGPointMake(12, 17) controlPoint1: CGPointMake(12.59, 15.5) controlPoint2: CGPointMake(12, 16.17)];
              [bezierPath addLineToPoint: CGPointMake(12, 36.5)];
              [bezierPath addCurveToPoint: CGPointMake(13.31, 38) controlPoint1: CGPointMake(12, 37.33) controlPoint2: CGPointMake(12.59, 38)];
              [bezierPath addLineToPoint: CGPointMake(31.69, 38)];
              [bezierPath addCurveToPoint: CGPointMake(33, 36.5) controlPoint1: CGPointMake(32.41, 38) controlPoint2: CGPointMake(33, 37.33)];
              [bezierPath addLineToPoint: CGPointMake(33, 17)];
              [bezierPath addCurveToPoint: CGPointMake(31.69, 15.5) controlPoint1: CGPointMake(33, 16.17) controlPoint2: CGPointMake(32.41, 15.5)];
              [bezierPath closePath];
              bezierPath.miterLimit = 4;
              
              [UIColor.whiteColor setFill];
              [bezierPath fill];
              [color setStroke];
              bezierPath.lineWidth = 1.5;
              [bezierPath stroke];

              
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


+ (UIImage*) andersonSpearCloudLogo:(CGSize) size
{
    
    return [UIImage imageWithIdentifier:@"andersonspearcloudlogo" forSize:size andDrawingBlock:^
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

+ (UIImage*) orangeButtonWithSize:(CGSize) inSize text:(NSString*) inText
{
    NSString *identifier = [NSString stringWithFormat:@"orangeButtonWithSize%@%f%f", inText, inSize.width, inSize.height];
    
    return [UIImage imageWithIdentifier:identifier forSize:inSize andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                CGFloat yellowHSBA[4];
                [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
                
                UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
                UIColor* color3 = [color colorWithAlphaComponent: 0.8];
                
                //// Frames
                CGRect frame = CGRectMake(0, 0, inSize.width, inSize.height);
                
                
                //// Abstracted Attributes
                NSString* buttonTextContent = inText;
                
                
                //// Rounded Rectangle Drawing
                UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00503) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.02830) + 0.5, floor(CGRectGetWidth(frame) * 0.99497) - floor(CGRectGetWidth(frame) * 0.00503), floor(CGRectGetHeight(frame) * 0.97170) - floor(CGRectGetHeight(frame) * 0.02830)) cornerRadius: 4];
                [color3 setFill];
                [roundedRectanglePath fill];
                [yellow setStroke];
                roundedRectanglePath.lineWidth = 1;
                [roundedRectanglePath stroke];
                
                
                //// buttonText Drawing
                CGRect buttonTextRect = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 295) * 0.33333 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 34) * 0.42105 + 0.5), 295, 34);
                [[UIColor whiteColor] setFill];
                [buttonTextContent drawInRect: buttonTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 30] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                

                
                
  
            }];
    
}


@end
