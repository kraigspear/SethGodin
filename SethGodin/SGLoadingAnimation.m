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
    NSInteger   _buttonTopContant;
    CALayer *_loadingBackgroundLayer;
    CALayer *_spinnerLayer;
}

- (id) initWithView:(UIView*) inView topConstraint:(NSLayoutConstraint*) inTopConstraint;
{
    self = [self init];
    
    _view = inView;
    _topConstraint = inTopConstraint;
    
    if(_topConstraint)
    {
        _buttonTopContant = inTopConstraint.constant - 500;
    }
    
    return self;
}


- (void) startLoadingAnimation
{
    if(_topConstraint)
    {
        _topConstraint.constant = _buttonTopContant;
        [_view layoutSubviews];
    }
    
    UIImage *loadingBackgroundImage = [UIImage imageNamed:@"load_bg.png"];
    UIImage *loadingTextImage       = [UIImage imageNamed:@"load_text.png"];
    
    CALayer *loadingTextLayer = [CALayer layer];
    loadingTextLayer.contents = (id) loadingTextImage.CGImage;
    
    CGFloat loadingTextX = (_view.frame.size.width / 2) - (loadingTextImage.size.width / 2);
    
    loadingTextLayer.frame = CGRectMake(loadingTextX, 25, loadingTextImage.size.width, loadingTextImage.size.height);
    
    _loadingBackgroundLayer = [CALayer layer];
    _loadingBackgroundLayer.contents = (id) loadingBackgroundImage.CGImage;
    _loadingBackgroundLayer.frame = CGRectMake(0, 0, loadingBackgroundImage.size.width, loadingBackgroundImage.size.height);
    
    [_loadingBackgroundLayer addSublayer:loadingTextLayer];
    
    [self startSpinner];
    
    [_view.layer addSublayer:_loadingBackgroundLayer];
    
   
    
}

- (void) startSpinner
{
    _spinnerLayer = [CALayer layer];
    
    UIImage *spinnerImage;
    
    if(_loadingBackgroundLayer)
    {
        spinnerImage = [UIImage imageNamed:@"load_spinner.png"];
    }
    else
    {
        spinnerImage = [UIImage imageNamed:@"smallspinner.png"];
    }
    
    
    _spinnerLayer.anchorPoint = CGPointMake(.5, .5);

    _spinnerLayer.contents = (id) spinnerImage.CGImage;
    
    if(_loadingBackgroundLayer)
    {
        _spinnerLayer.frame = CGRectMake(215, 180, spinnerImage.size.width, spinnerImage.size.height);
    }
    else
    {
        _spinnerLayer.frame = CGRectMake(255, 60, spinnerImage.size.width, spinnerImage.size.height);
    }
    
    
    if(_loadingBackgroundLayer)
    {
        [_loadingBackgroundLayer addSublayer:_spinnerLayer];
    }
    else
    {
        [_view.layer addSublayer:_spinnerLayer];
    }
    
    CABasicAnimation *spinnerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spinnerAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    spinnerAnimation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    spinnerAnimation.duration = 1;             // this might be too fast
    spinnerAnimation.repeatCount = HUGE_VALF;     // HUGE_VALF is defined in math.h so import it
    [_spinnerLayer addAnimation:spinnerAnimation forKey:@"rotation"];
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
         _loadingBackgroundLayer.opacity = 0;
     }
     completion:^(BOOL finished)
     {
         if(finished)
         {
             [self stopSpinner];
             [_loadingBackgroundLayer removeFromSuperlayer];
             _loadingBackgroundLayer = nil;
         }
     }];
}



@end
