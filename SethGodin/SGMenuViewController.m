//
//  SGMenuViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/12/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGMenuViewController.h"
#import "UIImage+General.h"
#import "UIImage+Menu.h"
#import "SGArchiveSelectionViewController.h"
#import "SGUpdradeViewController.h"
#import "SGNotifications.h"
#import "SGUserDefaults.h"
#import "UIColor+General.h"
#import "UIFont+General.h"


@implementation SGMenuViewController
{
@private

    id _networkAvailableNotification;
    
    UIButton *_latestButton;
    UIButton *_favoritesButton;
    UIButton *_archivesButton;
    UIButton *_booksButton;
    UIButton *_settingsButton;
    
    NSArray *_portraitConstraints;
    NSArray *_landscapeConstraints;

}

NSString * const SEGUE_MENU_TO_UPGRADE = @"menuToUpgrade";

- (void) viewDidLoad
{
    [super viewDidLoad];

    
    UIImage *booksImage   = [UIImage menuImageWithText:@"Books" isUpgrade:NO];
    UIImage *allPostImage = [UIImage menuImageWithText:@"Latest" isUpgrade:NO];
    
    UIImage *favoritesImage = [UIImage menuImageWithText:@"Favorites" isUpgrade:NO];
    UIImage *archivesImage  = [UIImage menuImageWithText:@"Archives"      isUpgrade:NO];
    
    UIImage *settingsImage = [UIImage menuImageWithText:@"Settings"      isUpgrade:NO];
    
    
    _latestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _latestButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_latestButton setImage:allPostImage forState:UIControlStateNormal];
    [_latestButton addTarget:self action:@selector(currentPostAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_latestButton];
    
    _favoritesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _favoritesButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_favoritesButton setImage:favoritesImage forState:UIControlStateNormal];
    [_favoritesButton addTarget:self action:@selector(favoritesAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_favoritesButton];
    
    _archivesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_archivesButton setImage:archivesImage forState:UIControlStateNormal];
    _archivesButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_archivesButton addTarget:self action:@selector(archivesAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_archivesButton];
    
    //books
    _booksButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_booksButton setImage:booksImage forState:UIControlStateNormal];
    _booksButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_booksButton addTarget:self action:@selector(booksAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_booksButton];
    
    //settings
    _settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingsButton setImage:settingsImage forState:UIControlStateNormal];
    _settingsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_settingsButton addTarget:self action:@selector(settingsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_settingsButton];
    
    //
    [self setupPortriateConstraints];
    [self setupLandscapeConstraints];
    
    _networkAvailableNotification = [SGNotifications observeNetworkAvailableWithNotification:^(NSNotification *note)
    {
        self.isNetworkAvailable = [note.object boolValue];
        _archivesButton.enabled = self.isNetworkAvailable;
        _booksButton.enabled = self.isNetworkAvailable;
    }];
    
    _archivesButton.enabled = self.isNetworkAvailable;
    _booksButton.enabled = self.isNetworkAvailable;
    
    [self updateConstraintsForOrientation:self.interfaceOrientation];
    
}

- (void) updateConstraintsForOrientation:(UIInterfaceOrientation) toInterfaceOrientation
{
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        [self.view removeConstraints:_landscapeConstraints];
        [self.view addConstraints:_portraitConstraints];
    }
    else
    {
        [self.view removeConstraints:_portraitConstraints];
        [self.view addConstraints:_landscapeConstraints];
    }

}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self updateConstraintsForOrientation:toInterfaceOrientation];
}

- (void) setupPortriateConstraints
{
    NSMutableArray *constraints = [NSMutableArray array];
    
    //latest
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_latestButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleBar attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:_latestButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:20 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, leadingConstraint]];
    
    //favorites
    topConstraint = [NSLayoutConstraint constraintWithItem:_favoritesButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_latestButton attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    leadingConstraint = [NSLayoutConstraint constraintWithItem:_favoritesButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_latestButton attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, leadingConstraint]];
    
    //archives
    
    topConstraint = [NSLayoutConstraint constraintWithItem:_archivesButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_favoritesButton attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    leadingConstraint = [NSLayoutConstraint constraintWithItem:_archivesButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_favoritesButton attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, leadingConstraint]];
    
    //books
    topConstraint = [NSLayoutConstraint constraintWithItem:_booksButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_archivesButton attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    leadingConstraint = [NSLayoutConstraint constraintWithItem:_booksButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_archivesButton attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, leadingConstraint]];
    
    //settings
    topConstraint = [NSLayoutConstraint constraintWithItem:_settingsButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_booksButton attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    leadingConstraint = [NSLayoutConstraint constraintWithItem:_settingsButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_booksButton attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, leadingConstraint]];
    //
    
    _portraitConstraints = constraints;
    
}

- (void) setupLandscapeConstraints
{
    NSMutableArray *constraints = [NSMutableArray array];
    
    //latest
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_latestButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleBar attribute:NSLayoutAttributeBottom multiplier:1 constant:20];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:_latestButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:20 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, leadingConstraint]];
    
    //favorites
    topConstraint = [NSLayoutConstraint constraintWithItem:_favoritesButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_latestButton attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:_favoritesButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:100];
    
    [constraints addObjectsFromArray:@[topConstraint, trailingConstraint]];
    
    //archives
    topConstraint = [NSLayoutConstraint constraintWithItem:_archivesButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_latestButton attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    leadingConstraint = [NSLayoutConstraint constraintWithItem:_archivesButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_latestButton attribute:NSLayoutAttributeLeading multiplier:0 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, leadingConstraint]];
    
    //books
    topConstraint = [NSLayoutConstraint constraintWithItem:_booksButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_favoritesButton attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    trailingConstraint = [NSLayoutConstraint constraintWithItem:_booksButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_favoritesButton attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    [constraints addObjectsFromArray:@[topConstraint, trailingConstraint]];
    
    
    //settings
    topConstraint = [NSLayoutConstraint constraintWithItem:_settingsButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_archivesButton attribute:NSLayoutAttributeBottom multiplier:1 constant:-15];
    
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:_settingsButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:75];
    
    [constraints addObjectsFromArray:@[topConstraint, centerConstraint]];
    
    //
    
    _landscapeConstraints = constraints;
    
}


- (void) viewDidLayoutSubviews
{
    self.buttonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage backgroundImageForSize:self.buttonView.frame.size]];
}

- (void) closeMenuWithAnimation:(BOOL) inShouldAnimate
{
    [[NSNotificationCenter defaultCenter] removeObserver:_networkAvailableNotification];
    _networkAvailableNotification = nil;
    self.close(inShouldAnimate);
}

- (void)currentPostAction:(id)sender
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsCurrent];
    [SGNotifications postFeedSelection:feedSelection];
    [self closeMenuWithAnimation:YES];
}

- (void) settingsAction:(id) sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)archivesAction:(id)sender
{
    [self selectArchives];
}

- (void) favoritesAction:(id)sender
{
    
    if([SGUserDefaults sharedInstance].isUpgraded)
    {
        [self selectFavorites];
    }
    else
    {
        [self showUpradeView];
    }
    
}

- (void) booksAction:(id) sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"books"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectFavorites
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsFavorites];
    [SGNotifications postFeedSelection:feedSelection];
    [self closeMenuWithAnimation:YES];
}

- (void) selectArchives
{
    [self performSegueWithIdentifier:@"archivesSegue" sender:self];
}

- (void) showUpradeView
{
    [self performSegueWithIdentifier:SEGUE_MENU_TO_UPGRADE sender:self];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}

#pragma mark -
#pragma mark segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:SEGUE_MENU_TO_UPGRADE])
    {
        SGUpdradeViewController *vc = segue.destinationViewController;
        vc.popbackViewController = self;
    }
}


#pragma mark -
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"MENU";
}

- (UIImage*) rightButtonImage
{
    return [UIImage closeButtonWithColor:[UIColor menuTitleBarTextColor]];
}

- (void) rightButtonAction:(id)sender
{
    [self closeMenuWithAnimation:YES];
}

- (UIColor*) titleViewBackgroundColor
{
    return [UIColor menuTitleBarBackgroundColor];
}

- (UIColor*) titleTextColor
{
    return [UIColor menuTitleBarTextColor];
}

@end
