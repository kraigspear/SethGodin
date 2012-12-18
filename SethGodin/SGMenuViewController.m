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

@implementation SGMenuViewController
{
@private
    id _feedSelectionNotification;
    id _networkAvailableNotification;
}

NSString * const SEGUE_MENU_TO_UPGRADE = @"menuToUpgrade";

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.titleBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"MENU"]];
    
    [self.closeButton setImage:[UIImage closeButton] forState:UIControlStateNormal];
    
    UIImage *booksImage   = [UIImage menuImageWithText:@"Books" isUpgrade:NO];
    UIImage *allPostImage = [UIImage menuImageWithText:@"Latest" isUpgrade:NO];
    
    UIImage *favoritesImage = [UIImage menuImageWithText:@"Favorites" isUpgrade:NO];
    UIImage *archivesImage  = [UIImage menuImageWithText:@"Archives"      isUpgrade:NO];
    
    UIImage *settingsButton = [UIImage menuImageWithText:@"Settings"      isUpgrade:NO];
    
    [self.booksBySethButton setImage:booksImage forState:UIControlStateNormal];
    [self.allPostButton     setImage:allPostImage forState:UIControlStateNormal];

    [self.favoritesButton setImage:favoritesImage forState:UIControlStateNormal];
    [self.archivesButton         setImage:archivesImage forState:UIControlStateNormal];
    
    [self.settingsButton setImage:settingsButton forState:UIControlStateNormal];
    
    _feedSelectionNotification = [SGNotifications observeFeedSelectionWithNotification:^(NSNotification * note)
    {
        [self closeMenuWithAnimation:NO];
    }];
    
    _networkAvailableNotification = [SGNotifications observeNetworkAvailableWithNotification:^(NSNotification *note)
    {
        self.isNetworkAvailable = [note.object boolValue];
        self.archivesButton.enabled = self.isNetworkAvailable;
        self.booksBySethButton.enabled = self.isNetworkAvailable;
    }];
    
    self.archivesButton.enabled = self.isNetworkAvailable;
    self.booksBySethButton.enabled = self.isNetworkAvailable;
}

- (void) viewDidLayoutSubviews
{
    self.buttonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage backgroundImageForSize:self.buttonView.frame.size]];
}

- (IBAction)closeAction:(id)sender
{
    [self closeMenuWithAnimation:YES];
}

- (void) closeMenuWithAnimation:(BOOL) inShouldAnimate
{
    [[NSNotificationCenter defaultCenter] removeObserver:_feedSelectionNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:_networkAvailableNotification];
    _feedSelectionNotification = nil;
    _networkAvailableNotification = nil;
    self.close(inShouldAnimate);
}


- (IBAction)currentPostAction:(id)sender
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsCurrent];
    [SGNotifications postFeedSelection:feedSelection];
    [self closeMenuWithAnimation:YES];
}

- (IBAction)archivesAction:(id)sender
{
    [self selectArchives];
}

- (IBAction)favoritesAction:(id)sender
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


@end
