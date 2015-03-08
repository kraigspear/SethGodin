//
//  SGTitleView.m
//  SethGodin
//
//  Created by Kraig Spear on 1/20/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGTitleView.h"
#import "UIFont+General.h"
#import "UIColor+General.h"
#import "Masonry.h"

@implementation SGTitleView
{
@private
    __weak UILabel *_titleLabel;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
    }
    return self;
}

- (void) awakeFromNib
{
    
    if([self.delegate respondsToSelector:@selector(titleViewBackgroundColor)])
    {
        self.backgroundColor = [self.delegate titleViewBackgroundColor];
    }
    else
    {
        self.backgroundColor = [UIColor titlebarBackgroundColor];
    }
    
    [self addTitleLabel];
    [self addRightButton];
    [self addLeftButton];
}



- (void) addTitleLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    label.backgroundColor = [UIColor clearColor];
    label.text            = [self.delegate titleText];
    label.font            = [UIFont titleBarTitleFont];
    label.textAlignment   = NSTextAlignmentCenter;
    
    if([self.delegate respondsToSelector:@selector(titleTextColor)])
    {
        label.textColor = [self.delegate titleTextColor];
    }
    else
    {
        label.textColor = [UIColor menuTitleBarTextColor];
    }

    [self addSubview:label];

    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:5];
    
    [self addConstraints:@[centerX, centerY]];
    
    _titleLabel = label;
    

}

- (void) addRightButton
{
    if(![self.delegate respondsToSelector:@selector(rightButtonImage)]) return;
         
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [rightButton setImage:[self.delegate rightButtonImage] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:rightButton];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:rightButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:rightButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-5];
    
    [self addConstraints:@[centerY, trailing]];
    
}


- (void) rightButtonAction:(id) sender
{
    if(![self.delegate respondsToSelector:@selector(rightButtonAction:)]) return;
    [self.delegate rightButtonAction:sender];
}

- (void) leftButtonAction:(id) sender
{
    if(![self.delegate respondsToSelector:@selector(leftButtonAction:)]) return;
    [self.delegate leftButtonAction:sender];
}

- (void) addLeftButton
{
    if(![self.delegate respondsToSelector:@selector(leftButtonImage)]) return;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [leftButton setImage:[self.delegate leftButtonImage] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:leftButton];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:leftButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:leftButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:5];
    
    [self addConstraints:@[centerY, leading]];
    
}

@end
