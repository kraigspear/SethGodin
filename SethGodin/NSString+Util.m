//
//  NSString+Util.m
//  SethGodin
//
//  Created by Kraig Spear on 11/20/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (UIFont*) fontThatWillFitUsingFont:(UIFont*) inFont insideRect:(CGRect) inRect
{
    
    CGSize sizeForString;
    
    UIFont *smallerFont = [UIFont fontWithName:inFont.fontName size:inFont.pointSize];
    
    CGSize maxSize = CGSizeMake(inRect.size.width, 1000);
    
    do
    {
        sizeForString = [self sizeWithFont:smallerFont constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        
        if(sizeForString.height > inRect.size.height)
        {
            smallerFont = [UIFont fontWithName:inFont.fontName size:smallerFont.pointSize - 1];
        }
        
    } while (sizeForString.height > inRect.size.height );
    
    return smallerFont;
    
}

- (NSString*) removeUnwantedContentCharacters
{
    return [self stringByReplacingOccurrencesOfString:@"â" withString:@"'"];
}

@end
