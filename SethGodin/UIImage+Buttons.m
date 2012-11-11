//
//  UIImage+Buttons.m
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIImage+Buttons.h"
#import "UIImage+BBlock.h"

@implementation UIImage (Buttons)

+ (UIImage*) backButton
{
    return [UIImage imageWithIdentifier:@"backButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                
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

@end
