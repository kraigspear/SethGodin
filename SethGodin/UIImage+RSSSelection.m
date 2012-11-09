//
//  UIImage+RSSSelection.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIImage+RSSSelection.h"

#import "UIImage+BBlock.h"

@implementation UIImage (RSSSelection)

+ (UIImage*) upButton
{
    return [UIImage imageWithIdentifier:@"upButton" forSize:CGSizeMake(157,109) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                CGFloat yellowRGBA[4];
                [yellow getRed: &yellowRGBA[0] green: &yellowRGBA[1] blue: &yellowRGBA[2] alpha: &yellowRGBA[3]];
                
                UIColor* color12 = [UIColor colorWithRed: (yellowRGBA[0] * 0.9) green: (yellowRGBA[1] * 0.9) blue: (yellowRGBA[2] * 0.9) alpha: (yellowRGBA[3] * 0.9 + 0.1)];
                
                //// Rectangle 7 Drawing
                UIBezierPath* rectangle7Path = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 157, 109)];
                [color12 setFill];
                [rectangle7Path fill];
                
                
                //// Bezier 5 Drawing
                UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
                [bezier5Path moveToPoint: CGPointMake(62.75, 65.75)];
                [bezier5Path addLineToPoint: CGPointMake(94.75, 65.75)];
                [bezier5Path addLineToPoint: CGPointMake(78.75, 43.25)];
                [bezier5Path addLineToPoint: CGPointMake(62.75, 65.75)];
                [bezier5Path closePath];
                [[UIColor whiteColor] setFill];
                [bezier5Path fill];

            }];
}

+ (UIImage*) downButton
{
    return [UIImage imageWithIdentifier:@"downButton" forSize:CGSizeMake(164,109) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                
                //// Rectangle 8 Drawing
                UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 164, 109)];
                [yellow setFill];
                [rectangle8Path fill];
                
                
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
                [bezier4Path moveToPoint: CGPointMake(97.75, 43.25)];
                [bezier4Path addLineToPoint: CGPointMake(65.75, 43.25)];
                [bezier4Path addLineToPoint: CGPointMake(81.75, 65.75)];
                [bezier4Path addLineToPoint: CGPointMake(97.75, 43.25)];
                [bezier4Path closePath];
                [[UIColor whiteColor] setFill];
                [bezier4Path fill];
                
                
            }];
}

+ (UIImage*) titleBar
{
    return [UIImage imageWithIdentifier:@"titleBar" forSize:CGSizeMake(320,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                UIColor* color4 = [yellow colorWithAlphaComponent: 0.03];
                
                //// Abstracted Attributes
                NSString* textContent = @"SETH GODIN";
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 44)];
                [color4 setFill];
                [rectanglePath fill];
                
                
                //// Text Drawing
                CGRect textRect = CGRectMake(0, 7, 320, 30);
                [yellow setFill];
                [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 26] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                

            }];
}

+ (UIImage*) searchButton
{
    return [UIImage imageWithIdentifier:@"searchButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
                [bezier3Path moveToPoint: CGPointMake(33.97, 31.77)];
                [bezier3Path addLineToPoint: CGPointMake(28.13, 26.05)];
                [bezier3Path addCurveToPoint: CGPointMake(27.91, 25.88) controlPoint1: CGPointMake(28.06, 25.98) controlPoint2: CGPointMake(27.99, 25.93)];
                [bezier3Path addCurveToPoint: CGPointMake(29.48, 20.73) controlPoint1: CGPointMake(28.9, 24.39) controlPoint2: CGPointMake(29.48, 22.63)];
                [bezier3Path addCurveToPoint: CGPointMake(19.82, 11.26) controlPoint1: CGPointMake(29.48, 15.5) controlPoint2: CGPointMake(25.15, 11.26)];
                [bezier3Path addCurveToPoint: CGPointMake(10.16, 20.73) controlPoint1: CGPointMake(14.48, 11.26) controlPoint2: CGPointMake(10.16, 15.5)];
                [bezier3Path addCurveToPoint: CGPointMake(19.82, 30.19) controlPoint1: CGPointMake(10.16, 25.95) controlPoint2: CGPointMake(14.49, 30.19)];
                [bezier3Path addCurveToPoint: CGPointMake(25.08, 28.66) controlPoint1: CGPointMake(21.76, 30.19) controlPoint2: CGPointMake(23.56, 29.62)];
                [bezier3Path addCurveToPoint: CGPointMake(25.25, 28.87) controlPoint1: CGPointMake(25.13, 28.73) controlPoint2: CGPointMake(25.19, 28.8)];
                [bezier3Path addLineToPoint: CGPointMake(31.09, 34.59)];
                [bezier3Path addCurveToPoint: CGPointMake(32.53, 35.17) controlPoint1: CGPointMake(31.49, 34.98) controlPoint2: CGPointMake(32.01, 35.17)];
                [bezier3Path addCurveToPoint: CGPointMake(33.97, 34.59) controlPoint1: CGPointMake(33.05, 35.17) controlPoint2: CGPointMake(33.57, 34.98)];
                [bezier3Path addCurveToPoint: CGPointMake(33.97, 31.77) controlPoint1: CGPointMake(34.76, 33.81) controlPoint2: CGPointMake(34.76, 32.55)];
                [bezier3Path closePath];
                [bezier3Path moveToPoint: CGPointMake(19.82, 27.2)];
                [bezier3Path addCurveToPoint: CGPointMake(13.21, 20.73) controlPoint1: CGPointMake(16.18, 27.2) controlPoint2: CGPointMake(13.21, 24.3)];
                [bezier3Path addCurveToPoint: CGPointMake(19.82, 14.25) controlPoint1: CGPointMake(13.21, 17.16) controlPoint2: CGPointMake(16.18, 14.25)];
                [bezier3Path addCurveToPoint: CGPointMake(26.43, 20.73) controlPoint1: CGPointMake(23.46, 14.25) controlPoint2: CGPointMake(26.43, 17.16)];
                [bezier3Path addCurveToPoint: CGPointMake(19.82, 27.2) controlPoint1: CGPointMake(26.43, 24.3) controlPoint2: CGPointMake(23.46, 27.2)];
                [bezier3Path closePath];
                [yellow setFill];
                [bezier3Path fill];
            }];
}

+ (UIImage*) menuButton
{
    return [UIImage imageWithIdentifier:@"menuButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                
                //// Rectangle 12 Drawing
                UIBezierPath* rectangle12Path = [UIBezierPath bezierPathWithRect: CGRectMake(9.5, 14, 25, 3)];
                [yellow setFill];
                [rectangle12Path fill];
                
                
                //// Rectangle 13 Drawing
                UIBezierPath* rectangle13Path = [UIBezierPath bezierPathWithRect: CGRectMake(9.5, 21, 25, 3)];
                [yellow setFill];
                [rectangle13Path fill];
                
                
                //// Rectangle 14 Drawing
                UIBezierPath* rectangle14Path = [UIBezierPath bezierPathWithRect: CGRectMake(9.5, 28, 25, 3)];
                [yellow setFill];
                [rectangle14Path fill];
            }];
}

@end
