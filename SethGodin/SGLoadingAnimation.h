//
//  SGLoadingAnimation.h
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Loading animation
 */
@interface SGLoadingAnimation : NSObject

/**
 Init loading animation
 @param inView The view to do the animation on
 @param inTopConstriant The top constriant of the view.
 */
- (id) initWithView:(UIView*) inView topConstraint:(NSLayoutConstraint*) inTopConstraint;

/**
 Start the animation
 */
- (void) startLoadingAnimation;

/**
 Stop the animation
 */
- (void) stopLoadingAnimation;

@end
