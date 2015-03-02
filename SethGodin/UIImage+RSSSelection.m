//
//  UIImage+RSSSelection.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIImage+RSSSelection.h"
#import "NSString+Util.h"
#import "UIImage+BBlock.h"
#import "UIColor+General.h"

@implementation UIImage (RSSSelection)

+ (UIImage*) bottomTableCellForBooksForSize:(CGSize)inSize
{
     NSString *identifer = [NSString stringWithFormat:@"bottomTableCellForBooksForSize%@", NSStringFromCGSize(inSize)];
    
     return [UIImage imageWithIdentifier:identifer forSize:inSize andDrawingBlock:^
            {
                //// General Declarations
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.811 blue: 0 alpha: 1];
                CGFloat yellowHSBA[4];
                [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
                
                UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
                
                //// Gradient Declarations
                CGFloat gradientLocations[] = {0, 0.11, 0.21, 0.78, 1};
                CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)color.CGColor, (id)[color blendedColorWithFraction: 0.5 ofColor: yellow].CGColor, (id)yellow.CGColor, (id)yellow.CGColor, (id)color.CGColor], gradientLocations);
                
                CGRect frame = CGRectMake(0, 0, inSize.width, inSize.height);
                
                //// bottomLineImage Drawing
                CGRect bottomLineImageRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00000 + 0.5), CGRectGetMinY(frame) + 34, floor(CGRectGetWidth(frame) * 1.00000 + 0.5) - floor(CGRectGetWidth(frame) * 0.00000 + 0.5), 5);
                UIBezierPath* bottomLineImagePath = [UIBezierPath bezierPathWithRect: bottomLineImageRect];
                CGContextSaveGState(context);
                [bottomLineImagePath addClip];
                CGContextDrawLinearGradient(context, gradient,
                                            CGPointMake(CGRectGetMidX(bottomLineImageRect) + 142.73 * CGRectGetWidth(bottomLineImageRect) / 320, CGRectGetMidY(bottomLineImageRect) + 97.87 * CGRectGetHeight(bottomLineImageRect) / 5),
                                            CGPointMake(CGRectGetMidX(bottomLineImageRect) + -143.54 * CGRectGetWidth(bottomLineImageRect) / 320, CGRectGetMidY(bottomLineImageRect) + 128.63 * CGRectGetHeight(bottomLineImageRect) / 5),
                                            kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
                CGContextRestoreGState(context);
                
                //// Cleanup
                CGGradientRelease(gradient);
                CGColorSpaceRelease(colorSpace);
            }];
}

+ (UIImage*) bottomTableCellForSize:(CGSize) inSize
{
    NSString *identifer = [NSString stringWithFormat:@"bottomTableCellForSize%@", NSStringFromCGSize(inSize)];
    
    return [UIImage imageWithIdentifier:identifer forSize:inSize andDrawingBlock:^
            {
                //// General Declarations
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Color Declarations
                UIColor* color21 = [UIColor colorWithRed: 1 green: 0.987 blue: 0.95 alpha: 1];
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                CGFloat yellowHSBA[4];
                [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
                
                UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
                
                //// Gradient Declarations
                NSArray* gradientColors = [NSArray arrayWithObjects:
                                           (id)color.CGColor,
                                           (id)[UIColor colorWithRed: 1 green: 0.752 blue: 0 alpha: 1].CGColor,
                                           (id)yellow.CGColor,
                                           (id)yellow.CGColor,
                                           (id)color.CGColor, nil];
                CGFloat gradientLocations[] = {0, 0.11, 0.21, 0.78, 1};
                CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
                
                //// Frames
                CGRect frame = CGRectMake(0, 0, inSize.width, inSize.height);
                
                
                //// shareArrow Drawing
                UIBezierPath* shareArrowPath = [UIBezierPath bezierPath];
                [shareArrowPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 16.32, CGRectGetMaxY(frame) - 35.05)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 17.44, CGRectGetMaxY(frame) - 36.64) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 16.62, CGRectGetMaxY(frame) - 35.58) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 16.99, CGRectGetMaxY(frame) - 36.11)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 19.06, CGRectGetMaxY(frame) - 38.05) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 17.89, CGRectGetMaxY(frame) - 37.16) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 18.43, CGRectGetMaxY(frame) - 37.63)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 21.15, CGRectGetMaxY(frame) - 39.11) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 19.7, CGRectGetMaxY(frame) - 38.48) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 20.31, CGRectGetMaxY(frame) - 38.83)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 24.05, CGRectGetMaxY(frame) - 39.61) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 22, CGRectGetMaxY(frame) - 39.39) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 22.96, CGRectGetMaxY(frame) - 39.55)];
                [shareArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 24.05, CGRectGetMaxY(frame) - 44.27)];
                [shareArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 32.35, CGRectGetMaxY(frame) - 37.08)];
                [shareArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 24.05, CGRectGetMaxY(frame) - 30)];
                [shareArrowPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 24.05, CGRectGetMaxY(frame) - 35.14)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 22.96, CGRectGetMaxY(frame) - 35.11) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 23.78, CGRectGetMaxY(frame) - 35.14) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 23.41, CGRectGetMaxY(frame) - 35.13)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 21.45, CGRectGetMaxY(frame) - 34.95) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 22.51, CGRectGetMaxY(frame) - 35.09) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 22, CGRectGetMaxY(frame) - 35.04)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 19.82, CGRectGetMaxY(frame) - 34.54) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 20.89, CGRectGetMaxY(frame) - 34.86) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 20.43, CGRectGetMaxY(frame) - 34.72)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 18.01, CGRectGetMaxY(frame) - 33.78) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 19.21, CGRectGetMaxY(frame) - 34.36) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 18.6, CGRectGetMaxY(frame) - 34.11)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 16.34, CGRectGetMaxY(frame) - 32.62) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 17.42, CGRectGetMaxY(frame) - 33.46) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 16.86, CGRectGetMaxY(frame) - 33.1)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 15, CGRectGetMaxY(frame) - 30.84) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 15.82, CGRectGetMaxY(frame) - 32.13) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 15.38, CGRectGetMaxY(frame) - 31.54)];
                [shareArrowPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 16.32, CGRectGetMaxY(frame) - 35.05) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 15.18, CGRectGetMaxY(frame) - 32.41) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 15.62, CGRectGetMaxY(frame) - 33.79)];
                [shareArrowPath closePath];
                [color21 setFill];
                [shareArrowPath fill];
                
                
                //// bottomLineImage Drawing
                CGRect bottomLineImageRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00000 + 0.5), CGRectGetMinY(frame) + 36, floor(CGRectGetWidth(frame) * 1.00000 + 0.5) - floor(CGRectGetWidth(frame) * 0.00000 + 0.5), 1);
                UIBezierPath* bottomLineImagePath = [UIBezierPath bezierPathWithRect: bottomLineImageRect];
                CGContextSaveGState(context);
                [bottomLineImagePath addClip];
                CGContextDrawLinearGradient(context, gradient,
                                            CGPointMake(CGRectGetMidX(bottomLineImageRect) + 142.73 * CGRectGetWidth(bottomLineImageRect) / 320, CGRectGetMidY(bottomLineImageRect) + 19.57 * CGRectGetHeight(bottomLineImageRect) / 1),
                                            CGPointMake(CGRectGetMidX(bottomLineImageRect) + -143.54 * CGRectGetWidth(bottomLineImageRect) / 320, CGRectGetMidY(bottomLineImageRect) + 25.73 * CGRectGetHeight(bottomLineImageRect) / 1),
                                            kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
                CGContextRestoreGState(context);
                
                
                //// Cleanup
                CGGradientRelease(gradient);
                CGColorSpaceRelease(colorSpace);
            }];
}

+ (UIImage*) searchButton
{
    return [UIImage imageWithIdentifier:@"searchButton" forSize:CGSizeMake(44,44) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor whiteColor];
                
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
                UIColor* yellow = [UIColor whiteColor];
                
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

+ (UIImage*) rssItemButtonForColor:(UIColor*) inColor andSize:(CGSize) inSize
{
    CGFloat r,g,b,a;
    [inColor getRed:&r green:&g blue:&b alpha:&a];
    
    NSString *identifier = [NSString stringWithFormat:@"%f%f%f%f%f%f", r, g, b,a, inSize.width, inSize.height];
    
    return [UIImage imageWithIdentifier:identifier forSize:inSize andDrawingBlock:^
    {
        //// Color Declarations
        UIColor* buttonColor = inColor;
        
        //// Frames
        CGRect outerFrame = CGRectMake(0, 0, 320, 132);
        
        
        //// buttonRect Drawing
        UIBezierPath* buttonRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(outerFrame) + floor(CGRectGetWidth(outerFrame) * 0.00000 + 0.5), CGRectGetMinY(outerFrame) + floor(CGRectGetHeight(outerFrame) * 0.00000 + 0.5), floor(CGRectGetWidth(outerFrame) * 1.00000 + 0.5) - floor(CGRectGetWidth(outerFrame) * 0.00000 + 0.5), floor(CGRectGetHeight(outerFrame) * 1.00000 + 0.5) - floor(CGRectGetHeight(outerFrame) * 0.00000 + 0.5))];
        [buttonColor setFill];
        [buttonRectPath fill];
    }];
}

+ (UIImage*) rssItemButtonForColor:(UIColor*) inColor
             andSize:(CGSize) inSize
             title:(NSString*) inTitle
             shared:(NSUInteger) inShare
             forDate:(NSDate*) inDate
             formatDateWith:(NSDateFormatter*) inFormatter
{
    //CGRect outerFrame = CGRectMake(0, 0, inSize.width, inSize.height);
    //UIColor* buttonColor = inColor;
    /*
        UIColor* buttonColor = inColor; 
        NSString* titleTextContent = inTitle;
        NSString* shareTextContent = [NSString stringWithFormat:@"%d", inShare];
        NSString* dateTextContent =  [inFormatter stringFromDate:inDate];
     */
    return [UIImage imageForSize:inSize withDrawingBlock:^
    {
        //// Color Declarations
        UIColor* buttonColor = inColor;
        CGFloat buttonColorRGBA[4];
        [buttonColor getRed: &buttonColorRGBA[0] green: &buttonColorRGBA[1] blue: &buttonColorRGBA[2] alpha: &buttonColorRGBA[3]];
        
        UIColor* color15 = [UIColor colorWithRed: (buttonColorRGBA[0] * 0.85) green: (buttonColorRGBA[1] * 0.85) blue: (buttonColorRGBA[2] * 0.85) alpha: (buttonColorRGBA[3] * 0.85 + 0.15)];
        
        //// Frames
        CGRect outerFrame = CGRectMake(0, 0, inSize.width, inSize.height);
        
        //// Subframes
        CGRect arrowFrame = CGRectMake(CGRectGetMinX(outerFrame) + CGRectGetWidth(outerFrame) - 311, CGRectGetMinY(outerFrame) + floor((CGRectGetHeight(outerFrame) - 20) * 0.87500 + 0.5), 27, 20);
        
        
        //// Abstracted Attributes
        NSString* titleTextContent = inTitle;
        NSString* shareTextContent = [NSString stringWithFormat:@"%d", inShare];
        NSString* dateTextContent = [inFormatter stringFromDate:inDate];
        
        
        //// buttonRect Drawing
        UIBezierPath* buttonRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(outerFrame) + floor(CGRectGetWidth(outerFrame) * 0.00000 + 0.5), CGRectGetMinY(outerFrame) + floor(CGRectGetHeight(outerFrame) * 0.00000 + 0.5), floor(CGRectGetWidth(outerFrame) * 1.00000 + 0.5) - floor(CGRectGetWidth(outerFrame) * 0.00000 + 0.5), floor(CGRectGetHeight(outerFrame) * 1.00000 + 0.5) - floor(CGRectGetHeight(outerFrame) * 0.00000 + 0.5))];
        [buttonColor setFill];
        [buttonRectPath fill];
        
        
        //// titleText Drawing
        CGRect titleTextRect = CGRectMake(CGRectGetMinX(outerFrame) + 16, CGRectGetMinY(outerFrame) + 10, 282, 84);
        [[UIColor whiteColor] setFill];
        
        CGRect smallerRect = CGRectInset(titleTextRect, 0, 5);
        UIFont *textFont = [titleTextContent fontThatWillFitUsingFont:[UIFont fontWithName: @"HelveticaNeue-Bold" size: 21.5] insideRect:smallerRect];
        
        [titleTextContent drawInRect: titleTextRect withFont: textFont lineBreakMode: NSLineBreakByWordWrapping alignment: UITextAlignmentLeft];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.30807 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.05)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.34959 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 9.64) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.31908 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.58) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.33293 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 9.11)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.40981 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 11.05) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.36626 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 10.16) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.38633 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 10.63)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.48715 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 12.11) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.43329 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 11.48) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.45593 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 11.83)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.59460 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 12.61) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.51838 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 12.39) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.55420 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 12.55)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.59460 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 17.27)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.90200 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 10.08)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.59460 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 3)];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.59460 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.14)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.55407 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.11) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.58437 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.14) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.57087 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.13)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.49798 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 7.95) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.53726 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.09) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.51857 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.04)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.43775 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 7.54) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.47738 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 7.86) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.46045 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 7.72)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.37085 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 6.78) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.41506 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 7.36) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.39275 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 7.11)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.30905 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 5.62) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.34893 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 6.46) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.32833 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 6.1)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.25926 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 3.84) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.28976 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 5.13) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.27316 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 4.54)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(arrowFrame) + 0.30807 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 8.05) controlPoint1: CGPointMake(CGRectGetMinX(arrowFrame) + 0.26582 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 5.41) controlPoint2: CGPointMake(CGRectGetMinX(arrowFrame) + 0.28209 * CGRectGetWidth(arrowFrame), CGRectGetMaxY(arrowFrame) - 6.79)];
        [bezierPath closePath];
        [color15 setFill];
        [bezierPath fill];
        
        
        //// shareText Drawing
        CGRect shareTextRect = CGRectMake(CGRectGetMinX(outerFrame) + CGRectGetWidth(outerFrame) - 281, CGRectGetMinY(outerFrame) + floor((CGRectGetHeight(outerFrame) - 22) * 0.88182 + 0.5), 65, 22);
        [color15 setFill];
        [shareTextContent drawInRect: shareTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBold" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: UITextAlignmentLeft];
        
        
        //// dateText Drawing
        CGRect dateTextRect = CGRectMake(CGRectGetMinX(outerFrame) + 104, CGRectGetMinY(outerFrame) + floor((CGRectGetHeight(outerFrame) - 21) * 0.86486 + 0.5), 194, 21);
        [color15 setFill];
        [dateTextContent drawInRect: dateTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBold" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: UITextAlignmentRight];
        
        

        
        
    }];
    
   
}


+ (UIImage*) warningMessage:(NSString*) inMessage forSize:(CGSize) inSize
{
    return [UIImage imageForSize:inSize withDrawingBlock:^
     {
         //// Color Declarations
         UIColor* lightGreen = [UIColor colorWithRed: 0.678 green: 0.796 blue: 0.364 alpha: 1];
         
         //// Frames
         CGRect frame = CGRectMake(0, 0, inSize.width, inSize.height);
         
         
         //// Abstracted Attributes
         NSString* messageTextContent = inMessage;
         
         //// innerRect Drawing
         UIBezierPath* innerRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * -0.00313 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.00000 + 0.5), floor(CGRectGetWidth(frame) * 1.00000 + 0.5) - floor(CGRectGetWidth(frame) * -0.00313 + 0.5), floor(CGRectGetHeight(frame) * 1.00208 + 0.5) - floor(CGRectGetHeight(frame) * 0.00000 + 0.5))];
         [lightGreen setFill];
         [innerRectPath fill];
         
         
         //// messageText Drawing
         CGRect messageTextRect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 291, CGRectGetMinY(frame) + CGRectGetHeight(frame) - 351, 262, 222);
         [[UIColor whiteColor] setFill];
         
         NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
         [style setAlignment: NSTextAlignmentCenter];
         
         [messageTextContent drawInRect:messageTextRect withFont:[UIFont fontWithName: @"HelveticaNeue-Bold" size: 22.5] lineBreakMode: NSLineBreakByClipping alignment:NSTextAlignmentCenter];

     }];
}

@end
