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

@implementation SGMenuViewController
{
@private
    id _feedSelectionNotification;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.titleBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"Seth Godin"]];
    [self.closeButton setImage:[UIImage closeButton] forState:UIControlStateNormal];
    
    UIImage *booksImage   = [UIImage menuImageWithText:@"Books By Seth Godin" isUpgrade:NO];
    UIImage *allPostImage = [UIImage menuImageWithText:@"All Blog Posts" isUpgrade:NO];
    
    UIImage *favoritesImage = [UIImage menuImageWithText:@"Favorite Post" isUpgrade:YES];
    UIImage *archivesImage  = [UIImage menuImageWithText:@"Archives"      isUpgrade:YES];
    
    [self.booksBySethButton setImage:booksImage forState:UIControlStateNormal];
    [self.allPostButton     setImage:allPostImage forState:UIControlStateNormal];

    [self.favoritesButton setImage:favoritesImage forState:UIControlStateNormal];
    [self.archivesButton         setImage:archivesImage forState:UIControlStateNormal];
    [self.alreadyUpgradedButton setImage:[UIImage alreadyUpgraded] forState:UIControlStateNormal];
    
    _feedSelectionNotification = [[SGNotifications sharedInstance] observeFeedSelectionWithNotification:^(NSNotification * note)
    {
        [self closeMenuWithAnimation:NO];
    }];
    
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
    _feedSelectionNotification = nil;
    self.close(inShouldAnimate);
}

@end
