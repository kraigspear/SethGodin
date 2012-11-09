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

@end
