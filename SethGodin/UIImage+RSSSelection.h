//
//  UIImage+RSSSelection.h
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RSSSelection)

/**
 Bottom of a blog entry table cell.
 Share image and table cell divider.
 */
+ (UIImage*) bottomTableCell;
+ (UIImage*) searchButton;
+ (UIImage*) menuButton;

+ (UIImage*) rssItemButtonForColor:(UIColor*) inColor
                           andSize:(CGSize) inSize
                             title:(NSString*) inTitle
                            shared:(NSUInteger) inShare
                           forDate:(NSDate*) inDate
                    formatDateWith:(NSDateFormatter*) inFormatter;

+ (UIImage*) rssItemButtonForColor:(UIColor*) inColor andSize:(CGSize) inSize;

+ (UIImage*) warningMessage:(NSString*) inMessage forSize:(CGSize) inSize;

@end
