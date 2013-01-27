//
//  UIFont+General.m
//  SethGodin
//
//  Created by Kraig Spear on 1/14/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "UIFont+General.h"

@implementation UIFont (General)

+ (UIFont*) blogEntriesTitleFont
{
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:26];
}

+ (UIFont*) titleBarTitleFont
{
    return [UIFont blogEntriesTitleFont];
}

+ (UIFont*) menuButtonFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
}

+ (UIFont*) messageTextFont
{
    return [UIFont menuButtonFont];
}


@end
