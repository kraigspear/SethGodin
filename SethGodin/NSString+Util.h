//
//  NSString+Util.h
//  SethGodin
//
//  Created by Kraig Spear on 11/20/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Util)

- (UIFont*) fontThatWillFitUsingFont:(UIFont*) inFont insideRect:(CGRect) inRect;

@end
