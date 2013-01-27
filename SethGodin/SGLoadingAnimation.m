//
//  SGLoadingAnimation.m
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGLoadingAnimation.h"
#import <QuartzCore/QuartzCore.h>

@implementation SGLoadingAnimation
{
@private
    __weak UIView *_view;
    __weak NSLayoutConstraint *_topConstraint;
    __weak UIImageView *_loadingImageView;
    UIView *_animationView;
    NSInteger   _buttonTopConstant;
    CALayer *_spinnerLayer;
}

- (id) initWithView:(UIView*) inView topConstraint:(NSLayoutConstraint*) inTopConstraint;
{
    self = [self init];
    
    _view = inView;
    _topConstraint = inTopConstraint;
    
    if(_topConstraint)
    {
        _buttonTopConstant = inTopConstraint.constant - 500;
    }
    
    return self;
}


- (void) startLoadingAnimation
{
    if(_topConstraint)
    {
        _topConstraint.constant = _buttonTopConstant;
        [_view layoutSubviews];
    }
    
    _animationView = [[UIView alloc] init];

    _animationView.translatesAutoresizingMaskIntoConstraints = NO;
    _animationView.backgroundColor = [UIColor whiteColor];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_animationView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_animationView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:_animationView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];

    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:_animationView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];

    [_view addSubview:_animationView];
    
    [_view addConstraints:@[topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]];
    
    UIImage *loadingBackgroundImage = [UIImage imageNamed:@"sethsmall.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:loadingBackgroundImage];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    bottomConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_animationView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_animationView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [_animationView addSubview:imageView];
    
    [_view addConstraints:@[bottomConstraint, centerX]];
    
    UIImage *loadingTextImage       = [UIImage imageNamed:@"load_text.png"];

    UIImageView *loadingTextImageView = [[UIImageView alloc] initWithImage:loadingTextImage];
    _loadingImageView = loadingTextImageView;
    loadingTextImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    topConstraint = [NSLayoutConstraint constraintWithItem:loadingTextImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_view attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    
    centerX = [NSLayoutConstraint constraintWithItem:loadingTextImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [_animationView addSubview:loadingTextImageView];
    [_view addConstraints:@[topConstraint, centerX]];
    
    [_view layoutIfNeeded];
    [self startSpinner];
    
}

- (void) startSpinner
{
    UIImage *spinnerImage;
    
    if(_animationView)
    {
        spinnerImage = [UIImage imageNamed:@"load_spinner.png"];
    }
    else
    {
        spinnerImage = [UIImage imageNamed:@"smallspinner.png"];
    }
    
    UIImageView *spinnerImageView = [[UIImageView alloc] initWithImage:spinnerImage];
    spinnerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:spinnerImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_loadingImageView attribute:NSLayoutAttributeTop multiplier:1 constant:60];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:spinnerImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_animationView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-50];
    
    [_animationView addSubview:spinnerImageView];
    [_view addConstraints:@[topConstraint, trailingConstraint]];
    
    spinnerImageView.layer.anchorPoint = CGPointMake(.5, .5);

    CABasicAnimation *spinnerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spinnerAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    spinnerAnimation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    spinnerAnimation.duration = 1;             // this might be too fast
    spinnerAnimation.repeatCount = HUGE_VALF;     // HUGE_VALF is defined in math.h so import it
    [spinnerImageView.layer addAnimation:spinnerAnimation forKey:@"rotation"];
}

- (void) stopSpinner
{
    [_spinnerLayer removeAllAnimations];
    [_spinnerLayer removeFromSuperlayer];
    _spinnerLayer = nil;
}

- (void) stopLoadingAnimation
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseOut animations:^
     {
         _animationView.layer.opacity = 0;
     }
     completion:^(BOOL finished)
     {
         if(finished)
         {
             [self stopSpinner];
             [_animationView removeFromSuperview];
             _animationView = nil;
         }
     }];
}



@end
