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
#import "UIImage+General.h"

@interface SGMenuController_iPad ()

@end

#define BUTTON_WIDTH .35f
#define BUTTON_HEIGHT .30f

@implementation SGMenuController_iPad
{
    __weak UIButton *_latestButton;
    __weak UIButton *_archiveButton;
    __weak UIButton *_favoritesButton;
    __weak UIButton *_booksButton;
    __weak UIButton *_settingsButton;
    NSArray *_buttons;
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
    [self.closeButton setImage:[UIImage closeButton] forState:UIControlStateNormal];

    //--  Latest
    UIButton *latestButton = [self newButtonWithTitle:@"Latest" action:@selector(latestAction:)];
    _latestButton = latestButton;
    //--
    
    NSLayoutConstraint *topConstraint =
	[NSLayoutConstraint
     constraintWithItem:latestButton
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.topView
     attribute:NSLayoutAttributeBottom
     multiplier:1.0f
     constant:12.0f];
    
    NSLayoutConstraint *leadingConstraint =
	[NSLayoutConstraint
     constraintWithItem:latestButton
     attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeLeading
     multiplier:1
     constant:20];
    
   // NSLayoutConstraint *widthConstraint = [self widthConstriant:latestButton];
    NSLayoutConstraint *heightConstriant = [self heightConstriant:latestButton];
    
    NSLayoutConstraint *trailingConstraint;
    
    [self.view addConstraints:@[topConstraint, leadingConstraint,  heightConstriant]];
    
    //Archive button
    UIButton *archiveButton = [self newButtonWithTitle:@"Archives" action:@selector(archiveAction:)];
    _archiveButton = archiveButton;
    
    topConstraint =
	[NSLayoutConstraint
     constraintWithItem:archiveButton
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:latestButton
     attribute:NSLayoutAttributeTop
     multiplier:1.0f
     constant:0.0f];
    
     trailingConstraint =
      [NSLayoutConstraint
      constraintWithItem:archiveButton
      attribute:NSLayoutAttributeTrailing
      relatedBy:NSLayoutRelationEqual
      toItem:self.view
      attribute:NSLayoutAttributeTrailing
      multiplier:1
      constant:-20];
    
    leadingConstraint =
    [NSLayoutConstraint
     constraintWithItem:archiveButton
     attribute:NSLayoutAttributeLeading
     relatedBy:NSLayoutRelationEqual
     toItem:latestButton
     attribute:NSLayoutAttributeTrailing
     multiplier:1.0f
     constant:20.0f];
    
    heightConstriant =
    [NSLayoutConstraint
     constraintWithItem:archiveButton
     attribute:NSLayoutAttributeHeight
     relatedBy:NSLayoutRelationEqual
     toItem:latestButton
     attribute:NSLayoutAttributeHeight
     multiplier:1.0f
     constant:0.0f];
    
    [self.view addConstraints:@[topConstraint, trailingConstraint,  heightConstriant]];
    
    //--favoritesButton
    
    UIButton *favoritesButton = [self newButtonWithTitle:@"Favorites" action:@selector(favoriatesAction:)];
    _favoritesButton = favoritesButton;
    
    leadingConstraint =
     [NSLayoutConstraint constraintWithItem:favoritesButton
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:latestButton
                                 attribute:NSLayoutAttributeLeading
                                 multiplier:1
                                 constant:0];
    
    topConstraint = [NSLayoutConstraint constraintWithItem:favoritesButton
                                                 attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:latestButton
                                                 attribute:NSLayoutAttributeBottom
                                                multiplier:1
                                                  constant:5];
    
    heightConstriant = [NSLayoutConstraint constraintWithItem:favoritesButton
                                                    attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:latestButton
                                                    attribute:NSLayoutAttributeHeight
                                                   multiplier:1
                                                     constant:0];
    
    [self.view addConstraints:@[leadingConstraint, topConstraint, heightConstriant]];
    //-- books button
    
    UIButton *booksButton = [self newButtonWithTitle:@"Books" action:@selector(booksAction:)];
    _booksButton = booksButton;
    
    leadingConstraint = [NSLayoutConstraint constraintWithItem:booksButton
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:archiveButton
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1
                                                      constant:0];
    
    topConstraint = [NSLayoutConstraint constraintWithItem:booksButton
                                                 attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:favoritesButton
                                                 attribute:NSLayoutAttributeTop
                                                multiplier:1
                                                  constant:0];
    
    
    heightConstriant = [NSLayoutConstraint constraintWithItem:booksButton
                                                    attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:archiveButton
                                                    attribute:NSLayoutAttributeHeight
                                                   multiplier:1
                                                     constant:0];
    
    [self.view addConstraints:@[leadingConstraint, topConstraint,  heightConstriant]];
    
    //settings
    UIButton *settingsButton = [self newButtonWithTitle:@"Account/Cloud" action:@selector(settingsAction:)];
    _settingsButton = settingsButton;

    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:settingsButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    heightConstriant = [self heightConstriant:settingsButton];
    
    topConstraint = [NSLayoutConstraint constraintWithItem:settingsButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.view addConstraints:@[centerX, topConstraint, heightConstriant]];
    
    //--
    
    _buttons = @[_latestButton, _favoritesButton, _booksButton, _archiveButton, settingsButton];
    
}

- (UIButton*) newButtonWithTitle:(NSString*) inTitle action:(SEL) inAction
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:inTitle forState:UIControlStateNormal];
    [self setButtonTextAttributes:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:inAction forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    return button;
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

- (IBAction)closeAction:(id)sender
{
    [self.delegate closeSelected:self];
}

- (void) latestAction:(id) sender
{
    [self.delegate latestSelected:self];
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsCurrent];
    [SGNotifications postFeedSelection:feedSelection];
    [self updateButtonTextColorForUnselected];
}

- (void) archiveAction:(id) sender
{
    [self.delegate archiveSelected:self];
    [self updateButtonTextColorForUnselected];
    _archiveButton.titleLabel.textColor = [UIColor textColorSelected];
}

- (void) favoriatesAction:(id) sender
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsFavorites];
    [SGNotifications postFeedSelection:feedSelection];
    [self updateButtonTextColorForUnselected];
    _favoritesButton.titleLabel.textColor = [UIColor textColorSelected];
}

- (void) booksAction:(id) sender
{
    [self.delegate booksSelected:self];
}

- (void) settingsAction:(id) sender
{
    UIStoryboard *iphoneStoryboard =  [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    UIViewController *settingsViewController = [iphoneStoryboard instantiateViewControllerWithIdentifier:@"account"];
    
    settingsViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:settingsViewController animated:YES completion:nil];
    
}

- (void) updateButtonTextColorForUnselected
{
    for(UIButton *button in _buttons)
    {
        button.titleLabel.textColor = [UIColor titlebarTextColor];
    }
}

@end
