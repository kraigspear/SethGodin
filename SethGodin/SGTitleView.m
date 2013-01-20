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
    [self addTitleLabel];
    [self addRightButton];
    [self updateView];
}

- (void) addTitleLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    label.text          = [self.delegate titleText];
    label.font          = [UIFont titleBarTitleFont];
    label.textAlignment = NSTextAlignmentCenter;
    
    if([self.delegate respondsToSelector:@selector(titleTextColor)])
    {
        label.textColor = [self.delegate titleTextColor];
    }
    else
    {
        label.textColor = [UIColor menuTitleBarTextColor];
    }
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addConstraints:@[centerX, centerY]];
    
    _titleLabel = label;
    
    [self addSubview:label];
}

- (void) addRightButton
{
    if(![self.delegate respondsToSelector:@selector(rightButtonImage)]) return;
         
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [rightButton setImage:[self.delegate rightButtonImage] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:rightButton];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:rightButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:rightButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-5];
    
    [self addConstraints:@[centerY, trailing]];
    
}


- (void) rightButtonAction:(id) sender
{
    if(![self.delegate respondsToSelector:@selector(rightButtonAction:)]) return;
    [self.delegate rightButtonAction:sender];
}

@end
