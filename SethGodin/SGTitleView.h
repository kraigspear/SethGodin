//
//  SGTitleView.h
//  SethGodin
//
//  Created by Kraig Spear on 1/20/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGTitleViewDelegate <NSObject>

- (NSString*) titleText;
- (UIColor*)  titleTextColor;
- (UIColor*)  titleViewBackgroundColor;

@optional
- (UIImage*) leftButtonImage;
- (UIImage*) rightButtonImage;

- (void) leftButtonAction:(id)  sender;
- (void) rightButtonAction:(id) sender;



@end

@interface SGTitleView : UIView

@property (nonatomic, weak) IBOutlet id<SGTitleViewDelegate> delegate;

@end
