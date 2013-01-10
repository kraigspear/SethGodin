//
//  SGMenuController_iPad.m
//  SethGodin
//
//  Created by Kraig Spear on 1/10/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGMenuController_iPad.h"

#import "UIColor+General.h"
#import "SGNotifications.h"

@interface SGMenuController_iPad ()

@end

#define BUTTON_WIDTH .45f
#define BUTTON_HEIGHT .30f

@implementation SGMenuController_iPad
{
    UIButton *latestButton;
    UIButton *archiveButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor menuBackgroundColor];

    //--  Latest
    latestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [latestButton setTitle:@"Latest" forState:UIControlStateNormal];
    [self setButtonTextAttributes:latestButton];
    latestButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [latestButton addTarget:self action:@selector(latestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:latestButton];
    //--
    
    NSLayoutConstraint *topConstraint =
	[NSLayoutConstraint
     constraintWithItem:latestButton
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeTop
     multiplier:1.0f
     constant:5.0f];
    
    NSLayoutConstraint *leadingConstraint =
	[NSLayoutConstraint
     constraintWithItem:latestButton
     attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeLeading
     multiplier:1.0f
     constant:20.0f];
    
    NSLayoutConstraint *widthConstraint = [self widthConstriant:latestButton];
    NSLayoutConstraint *heightConstriant = [self heightConstriant:latestButton];
    
    [self.view addConstraints:@[topConstraint, leadingConstraint, widthConstraint, heightConstriant]];
    
    //Archive button
    
    //--  Archives
    archiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [archiveButton setTitle:@"Archives" forState:UIControlStateNormal];
    archiveButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self setButtonTextAttributes:archiveButton];
    [self.view addSubview:archiveButton];
    
    topConstraint =
	[NSLayoutConstraint
     constraintWithItem:archiveButton
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:latestButton
     attribute:NSLayoutAttributeTop
     multiplier:1.0f
     constant:0.0f];
    
    leadingConstraint =
    [NSLayoutConstraint
     constraintWithItem:archiveButton
     attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:latestButton
     attribute:NSLayoutAttributeTrailing
     multiplier:1.0f
     constant:5.0f];
    
    widthConstraint = [self widthConstriant:archiveButton];
    heightConstriant = [self heightConstriant:archiveButton];
    
    [self.view addConstraints:@[topConstraint, leadingConstraint, widthConstraint, heightConstriant]];
    
    //--
    
    
}

- (void) setButtonTextAttributes:(UIButton*) inButton
{
    inButton.titleLabel.font      = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35];
    inButton.backgroundColor      = [UIColor menuBackgroundColor];
    inButton.titleLabel.textColor = [UIColor titlebarTextColor];
}

- (NSLayoutConstraint*) widthConstriant:(UIView*) inView
{
    NSLayoutConstraint *widthConstraint =
	[NSLayoutConstraint
     constraintWithItem:inView
     attribute:NSLayoutAttributeWidth
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeWidth
     multiplier:BUTTON_WIDTH
     constant:1.0f];
    
    return widthConstraint;
}

- (NSLayoutConstraint*) heightConstriant:(UIView*) inView
{
    NSLayoutConstraint *heightConstriant =
	[NSLayoutConstraint
     constraintWithItem:inView
     attribute:NSLayoutAttributeHeight
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeHeight
     multiplier:BUTTON_HEIGHT
     constant:1.0f];
    
    return heightConstriant;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark actions

- (void) latestAction:(id) sender
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsCurrent];
    [SGNotifications postFeedSelection:feedSelection];
}

@end
