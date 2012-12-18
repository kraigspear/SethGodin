//
//  UIImage+Upgrade.m
//  SethGodin
//
//  Created by Kraig Spear on 11/21/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "UIImage+Upgrade.h"

#import "UIImage+BBlock.h"

@implementation UIImage (Upgrade)

+ (UIImage*) upgradeBackgroundForSize:(CGSize) inSize
{
    
    return [UIImage imageForSize:inSize withDrawingBlock:^
    {
        //// Color Declarations
        UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
        CGFloat yellowHSBA[4];
        [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
        
        UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
        
        //// Frames
        CGRect backgroundFrame = CGRectMake(0, 0, inSize.width, inSize.height);
        
        
        //// Abstracted Attributes
        NSString* upgradetextContent = @"Upgrade to access Seth Godin's entire blog archive and your favorite posts.";
        
        
        //// bacgroundRect Drawing
        UIBezierPath* bacgroundRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(backgroundFrame) + floor(CGRectGetWidth(backgroundFrame) * 0.00000 + 0.5), CGRectGetMinY(backgroundFrame) + floor(CGRectGetHeight(backgroundFrame) * 0.00000 + 0.5), floor(CGRectGetWidth(backgroundFrame) * 1.00000 + 0.5) - floor(CGRectGetWidth(backgroundFrame) * 0.00000 + 0.5), floor(CGRectGetHeight(backgroundFrame) * 1.00000 + 0.5) - floor(CGRectGetHeight(backgroundFrame) * 0.00000 + 0.5))];
        [color setFill];
        [bacgroundRectPath fill];
        
        
        //// upgradetext Drawing
        CGRect upgradetextRect = CGRectMake(CGRectGetMinX(backgroundFrame) + CGRectGetWidth(backgroundFrame) - 300, CGRectGetMinY(backgroundFrame) + floor((CGRectGetHeight(backgroundFrame) - 460) * 0.51020 + 0.5), 276, 460);
        [[UIColor whiteColor] setFill];
        [upgradetextContent drawInRect: upgradetextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Bold" size: 25] lineBreakMode: NSLineBreakByWordWrapping alignment: UITextAlignmentCenter];
        
        

        
        

    }];
}

+ (UIImage*) upgradeButton
{
    return [UIImage imageWithIdentifier:@"upgradeButton" forSize:CGSizeMake(298,53) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                CGFloat yellowHSBA[4];
                [yellow getHue: &yellowHSBA[0] saturation: &yellowHSBA[1] brightness: &yellowHSBA[2] alpha: &yellowHSBA[3]];
                
                UIColor* color = [UIColor colorWithHue: 0.1 saturation: yellowHSBA[1] brightness: yellowHSBA[2] alpha: yellowHSBA[3]];
                UIColor* color3 = [color colorWithAlphaComponent: 0.8];
                
                //// Abstracted Attributes
                NSString* text2Content = @"UPGRADE";
                
                
                //// Rounded Rectangle Drawing
                UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1.5, 1.5, 295, 50) cornerRadius: 4];
                [color3 setFill];
                [roundedRectanglePath fill];
                [yellow setStroke];
                roundedRectanglePath.lineWidth = 1;
                [roundedRectanglePath stroke];
                
                
                //// Text 2 Drawing
                CGRect text2Rect = CGRectMake(6, 8, 296, 34);
                [[UIColor whiteColor] setFill];
                [text2Content drawInRect: text2Rect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 30] lineBreakMode: NSLineBreakByWordWrapping alignment: UITextAlignmentCenter];
            }];
}

+ (UIImage*) thankYouButton
{
    return [UIImage imageWithIdentifier:@"thankYouButton" forSize:CGSizeMake(299,55) andDrawingBlock:^
            {
                //// Color Declarations
                UIColor* lightGreen = [UIColor colorWithRed: 0.678 green: 0.796 blue: 0.364 alpha: 1];
                UIColor* yellow = [UIColor colorWithRed: 1 green: 0.837 blue: 0 alpha: 1];
                
                //// Abstracted Attributes
                NSString* text2Content = @"THANK YOU";
                
                
                //// Rounded Rectangle Drawing
                UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(2, 3, 295, 50) cornerRadius: 4];
                [lightGreen setFill];
                [roundedRectanglePath fill];
                [yellow setStroke];
                roundedRectanglePath.lineWidth = 1;
                [roundedRectanglePath stroke];
                
                
                //// Text 2 Drawing
                CGRect text2Rect = CGRectMake(4, 9, 295, 53);
                [[UIColor whiteColor] setFill];
                [text2Content drawInRect: text2Rect withFont: [UIFont fontWithName: @"HelveticaNeue-CondensedBlack" size: 30] lineBreakMode: NSLineBreakByWordWrapping alignment: UITextAlignmentCenter];

            }];
}



@end
