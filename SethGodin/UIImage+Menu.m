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


@end
