//
//  EPZToolBar.m
//  EPubTest
//
//  Created by Kraig Spear on 9/12/12.
//  Copyright (c) 2012 Kraig Spear. All rights reserved.
//

#import "EPZToolBar.h"

@implementation EPZToolBar

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //// Color Declarations
    UIColor* lineColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.91];
    UIColor* dkLine = [UIColor colorWithRed: 0.13 green: 0.13 blue: 0.13 alpha: 0.45];
    
    
    //// whiteLine Drawing
    UIBezierPath* whiteLinePath = [UIBezierPath bezierPath];
    [whiteLinePath moveToPoint: CGPointMake(0, 2)];
    [whiteLinePath addLineToPoint: CGPointMake(326, 2)];
    [lineColor setStroke];
    whiteLinePath.lineWidth = 1.5;
    [whiteLinePath stroke];
    
    
    //// darkLine Drawing
    UIBezierPath* darkLinePath = [UIBezierPath bezierPath];
    [darkLinePath moveToPoint: CGPointMake(0, 1)];
    [darkLinePath addLineToPoint: CGPointMake(326, 1)];
    [dkLine setStroke];
    darkLinePath.lineWidth = 1;
    [darkLinePath stroke];
    
    

}

@end
