//
//  UIImage+Account.m
//  SethGodin
//
//  Created by Kraig Spear on 1/31/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "UIImage+Account.h"
#import "UIImage+BBlock.h"

@implementation UIImage (Account)

+ (UIImage*) buttonImageWithTitle:(NSString*) title
{
    return [UIImage imageForSize:CGSizeMake(300, 55) withDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                CGFloat yellowHSBA[4];
                [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
                
                UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
                UIColor* color3 = [color colorWithAlphaComponent: 0.8];
                
                //// Abstracted Attributes
                NSString* buttonTextContent = title;
                
                //// buttonBackground Drawing
                UIBezierPath* buttonBackgroundPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(2.5, 2.5, 295, 50) cornerRadius: 4];
                [color3 setFill];
                [buttonBackgroundPath fill];
                [yellow setStroke];
                buttonBackgroundPath.lineWidth = 1;
                [buttonBackgroundPath stroke];
                
                
                //// buttonText Drawing
                CGRect buttonTextRect = CGRectMake(4, 9, 294, 44);
                [[UIColor whiteColor] setFill];
                [buttonTextContent drawInRect: buttonTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 30] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                

            }];
}

+ (UIImage*) backgroundImageForUserSignedIn:(NSString*) signedIn
{
    if(IS_IPHONE5)
    {
        return [UIImage backgroundImage5ForUserSignedIn:signedIn];
    }
    else
    {
        return [UIImage backgroundImage4ForUserSignedIn:signedIn];
    }
}

+ (UIImage*) backgroundImage5ForUserSignedIn:(NSString*) signedIn
{
    return [UIImage imageForSize:CGSizeMake(320, 548) withDrawingBlock:^
            {
                //// General Declarations
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                CGFloat yellowHSBA[4];
                [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
                
                UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
                CGFloat colorHSBA[4];
                [color getHue: &colorHSBA[0] saturation: &colorHSBA[1] brightness: &colorHSBA[2] alpha: &colorHSBA[3]];
                
                UIColor* color26 = [UIColor colorWithHue: colorHSBA[0] saturation: colorHSBA[1] brightness: 0.8 alpha: colorHSBA[3]];
                
                //// Gradient Declarations
                NSArray* gradientColors = [NSArray arrayWithObjects:
                                           (id)color.CGColor,
                                           (id)yellow.CGColor, nil];
                CGFloat gradientLocations[] = {0, 1};
                CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
                
                //// Shadow Declarations
                UIColor* shadow = [UIColor blackColor];
                CGSize shadowOffset = CGSizeMake(0.1, -3.1);
                CGFloat shadowBlurRadius = 7.5;
                
                //// Abstracted Attributes
                NSString* text5Content = @"by Anderson+Spear";
                NSString* text3Content = @"Create a free account to to keep your favorite posts from Seth Godin's Blog in sync with all your iOS devices.";
                NSString* text4Content = @"SETH GODIN";
                NSString* text7Content = @"SIGNED IN:";
                NSString* userNameTextContent = signedIn;
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(-1, 0, 321, 553)];
                CGContextSaveGState(context);
                [rectanglePath addClip];
                CGContextDrawLinearGradient(context, gradient, CGPointMake(159.5, -0), CGPointMake(159.5, 553), 0);
                CGContextRestoreGState(context);
                
                
                //// Rectangle 7 Drawing
                UIBezierPath* rectangle7Path = [UIBezierPath bezierPathWithRect: CGRectMake(-73, 343, 459, 238)];
                [color setFill];
                [rectangle7Path fill];
                
                ////// Rectangle 7 Inner Shadow
                CGRect rectangle7BorderRect = CGRectInset([rectangle7Path bounds], -shadowBlurRadius, -shadowBlurRadius);
                rectangle7BorderRect = CGRectOffset(rectangle7BorderRect, -shadowOffset.width, -shadowOffset.height);
                rectangle7BorderRect = CGRectInset(CGRectUnion(rectangle7BorderRect, [rectangle7Path bounds]), -1, -1);
                
                UIBezierPath* rectangle7NegativePath = [UIBezierPath bezierPathWithRect: rectangle7BorderRect];
                [rectangle7NegativePath appendPath: rectangle7Path];
                rectangle7NegativePath.usesEvenOddFillRule = YES;
                
                CGContextSaveGState(context);
                {
                    CGFloat xOffset = shadowOffset.width + round(rectangle7BorderRect.size.width);
                    CGFloat yOffset = shadowOffset.height;
                    CGContextSetShadowWithColor(context,
                                                CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                                shadowBlurRadius,
                                                shadow.CGColor);
                    
                    [rectangle7Path addClip];
                    CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(rectangle7BorderRect.size.width), 0);
                    [rectangle7NegativePath applyTransform: transform];
                    [[UIColor grayColor] setFill];
                    [rectangle7NegativePath fill];
                }
                CGContextRestoreGState(context);
                
                
                
                //// Text 5 Drawing
                CGRect text5Rect = CGRectMake(-1, 148, 320, 43);
                [[UIColor whiteColor] setFill];
                [text5Content drawInRect: text5Rect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 20] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                
                //// Text 3 Drawing
                CGRect text3Rect = CGRectMake(21, 189, 278, 93);
                [color26 setFill];
                [text3Content drawInRect: text3Rect withFont: [UIFont fontWithName: @"HelveticaNeue-Medium" size: [UIFont systemFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// Text 4 Drawing
                CGRect text4Rect = CGRectMake(0, 97, 320, 62);
                [[UIColor whiteColor] setFill];
                [text4Content drawInRect: text4Rect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 45] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// Text 7 Drawing
                CGRect text7Rect = CGRectMake(0, 294, 320, 31);
                [color26 setFill];
                [text7Content drawInRect: text7Rect withFont: [UIFont fontWithName: @"HelveticaNeue-Medium" size: [UIFont smallSystemFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// userNameText Drawing
                CGRect userNameTextRect = CGRectMake(0, 310, 320, 29);
                [color26 setFill];
                [userNameTextContent drawInRect: userNameTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: [UIFont smallSystemFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// Cleanup
                CGGradientRelease(gradient);
                CGColorSpaceRelease(colorSpace);
                

                

            }];
}

+ (UIImage*) backgroundImage4ForUserSignedIn:(NSString*) signedIn
{
    return [UIImage imageForSize:CGSizeMake(320, 460) withDrawingBlock:^
            {
                
                //// General Declarations
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGContextRef context = UIGraphicsGetCurrentContext();
                
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                CGFloat yellowHSBA[4];
                [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
                
                UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
                CGFloat colorHSBA[4];
                [color getHue: &colorHSBA[0] saturation: &colorHSBA[1] brightness: &colorHSBA[2] alpha: &colorHSBA[3]];
                
                UIColor* color26 = [UIColor colorWithHue: colorHSBA[0] saturation: colorHSBA[1] brightness: 0.8 alpha: colorHSBA[3]];
                
                //// Gradient Declarations
                NSArray* gradientColors = [NSArray arrayWithObjects:
                                           (id)color.CGColor,
                                           (id)yellow.CGColor, nil];
                CGFloat gradientLocations[] = {0, 1};
                CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
                
                //// Shadow Declarations
                UIColor* shadow = [UIColor blackColor];
                CGSize shadowOffset = CGSizeMake(0.1, -3.1);
                CGFloat shadowBlurRadius = 7.5;
                
                //// Abstracted Attributes
                NSString* text5Content = @"by Anderson+Spear";
                NSString* text3Content = @"Create a free account to to keep your favorite posts from Seth Godin's Blog in sync with all your iOS devices.";
                NSString* text4Content = @"SETH GODIN";
                NSString* text7Content = @"SIGNED IN:";
                NSString* signedInTextContent = @"andyanderson";
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(-1, 0, 321, 465)];
                CGContextSaveGState(context);
                [rectanglePath addClip];
                CGContextDrawLinearGradient(context, gradient, CGPointMake(159.5, -0), CGPointMake(159.5, 465), 0);
                CGContextRestoreGState(context);
                
                
                //// Rectangle 7 Drawing
                UIBezierPath* rectangle7Path = [UIBezierPath bezierPathWithRect: CGRectMake(-73, 255, 459, 238)];
                [color setFill];
                [rectangle7Path fill];
                
                ////// Rectangle 7 Inner Shadow
                CGRect rectangle7BorderRect = CGRectInset([rectangle7Path bounds], -shadowBlurRadius, -shadowBlurRadius);
                rectangle7BorderRect = CGRectOffset(rectangle7BorderRect, -shadowOffset.width, -shadowOffset.height);
                rectangle7BorderRect = CGRectInset(CGRectUnion(rectangle7BorderRect, [rectangle7Path bounds]), -1, -1);
                
                UIBezierPath* rectangle7NegativePath = [UIBezierPath bezierPathWithRect: rectangle7BorderRect];
                [rectangle7NegativePath appendPath: rectangle7Path];
                rectangle7NegativePath.usesEvenOddFillRule = YES;
                
                CGContextSaveGState(context);
                {
                    CGFloat xOffset = shadowOffset.width + round(rectangle7BorderRect.size.width);
                    CGFloat yOffset = shadowOffset.height;
                    CGContextSetShadowWithColor(context,
                                                CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                                shadowBlurRadius,
                                                shadow.CGColor);
                    
                    [rectangle7Path addClip];
                    CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(rectangle7BorderRect.size.width), 0);
                    [rectangle7NegativePath applyTransform: transform];
                    [[UIColor grayColor] setFill];
                    [rectangle7NegativePath fill];
                }
                CGContextRestoreGState(context);
                
                
                
                //// Text 5 Drawing
                CGRect text5Rect = CGRectMake(-1, 85, 320, 43);
                [[UIColor whiteColor] setFill];
                [text5Content drawInRect: text5Rect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 20] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// Text 3 Drawing
                CGRect text3Rect = CGRectMake(21, 126, 278, 93);
                [color26 setFill];
                [text3Content drawInRect: text3Rect withFont: [UIFont fontWithName: @"HelveticaNeue-Medium" size: [UIFont systemFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// Text 4 Drawing
                CGRect text4Rect = CGRectMake(0, 34, 320, 62);
                [[UIColor whiteColor] setFill];
                [text4Content drawInRect: text4Rect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 45] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// Text 7 Drawing
                CGRect text7Rect = CGRectMake(0, 206, 320, 31);
                [color26 setFill];
                [text7Content drawInRect: text7Rect withFont: [UIFont fontWithName: @"HelveticaNeue-Medium" size: [UIFont smallSystemFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// signedInText Drawing
                CGRect signedInTextRect = CGRectMake(0, 222, 320, 29);
                [color26 setFill];
                [signedInTextContent drawInRect: signedInTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: [UIFont smallSystemFontSize]] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
                
                
                //// Cleanup
                CGGradientRelease(gradient);
                CGColorSpaceRelease(colorSpace);
                

                
                
                
                
                

            }];
}

@end
