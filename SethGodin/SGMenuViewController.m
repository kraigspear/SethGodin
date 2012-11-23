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
#import "SGNotifications.h"
#import "SGUserDefaults.h"

@implementation SGMenuViewController
{
@private
    id _feedSelectionNotification;
    id _networkAvailableNotification;
    BOOL _upgradeArchive;
    BOOL _upgradeFavorites;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.titleBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"MENU"]];
    
    [self.closeButton setImage:[UIImage closeButton] forState:UIControlStateNormal];
    
    UIImage *booksImage   = [UIImage menuImageWithText:@"Books" isUpgrade:NO];
    UIImage *allPostImage = [UIImage menuImageWithText:@"Latest" isUpgrade:NO];
    
    UIImage *favoritesImage = [UIImage menuImageWithText:@"Favorites" isUpgrade:NO];
    UIImage *archivesImage  = [UIImage menuImageWithText:@"Archives"      isUpgrade:NO];
    
    [self.booksBySethButton setImage:booksImage forState:UIControlStateNormal];
    [self.allPostButton     setImage:allPostImage forState:UIControlStateNormal];

    [self.favoritesButton setImage:favoritesImage forState:UIControlStateNormal];
    [self.archivesButton         setImage:archivesImage forState:UIControlStateNormal];
    
    _feedSelectionNotification = [[SGNotifications sharedInstance] observeFeedSelectionWithNotification:^(NSNotification * note)
    {
        [self closeMenuWithAnimation:NO];
    }];
    
    _networkAvailableNotification = [[SGNotifications sharedInstance] observeNetworkAvailableWithNotification:^(NSNotification *note)
    {
        self.isNetworkAvailable = [note.object boolValue];
        self.archivesButton.enabled = self.isNetworkAvailable;
        self.booksBySethButton.enabled = self.isNetworkAvailable;
    }];
    
    self.archivesButton.enabled = self.isNetworkAvailable;
    self.booksBySethButton.enabled = self.isNetworkAvailable;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(_upgradeFavorites)
    {
        if([[SGUserDefaults sharedInstance] isUpgraded])
        {
            [self selectFavorites];
        }
    }
    
    if(_upgradeArchive)
    {
        if([[SGUserDefaults sharedInstance] isUpgraded])
        {
            [self selectArchives];
        }
    }
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
    [[SGNotifications sharedInstance] postFeedSelection:feedSelection];
    [self closeMenuWithAnimation:YES];
}

- (IBAction)archivesAction:(id)sender
{
    [self selectArchives];
}

- (IBAction)favoritesAction:(id)sender
{
    _upgradeFavorites = YES;
    [self showUpradeView];
    return;
    
    if([SGUserDefaults sharedInstance].isUpgraded)
    {
        [self selectFavorites];
    }
    else
    {
        _upgradeFavorites = YES;
        [self showUpradeView];
    }
    
}

- (void) selectFavorites
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsFavorites];
    [[SGNotifications sharedInstance] postFeedSelection:feedSelection];
    [self closeMenuWithAnimation:YES];
}

- (void) selectArchives
{
    _upgradeArchive = NO;
    [self performSegueWithIdentifier:@"archivesSegue" sender:self];
}

- (void) showUpradeView
{
    _upgradeFavorites = NO;
    [self performSegueWithIdentifier:@"menuToUpgrade" sender:self];
}

@end
