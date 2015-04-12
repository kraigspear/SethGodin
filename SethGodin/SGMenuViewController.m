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
#import "UIColor+General.h"
#import "UIFont+General.h"
#import "Masonry.h"


@implementation SGMenuViewController
{
@private

    id _networkAvailableNotification;
    
    UIButton *_latestButton;
    UIButton *_favoritesButton;
    UIButton *_archivesButton;
    UIButton *_booksButton;
    UIButton *_accountButton;
    
}

NSString * const SEGUE_MENU_TO_UPGRADE = @"menuToUpgrade";

- (void) viewDidLoad
{
    [super viewDidLoad];

    UIImage *booksImage   = [UIImage menuImageWithText:@"Books" isUpgrade:NO];
    UIImage *allPostImage = [UIImage menuImageWithText:@"Latest" isUpgrade:NO];
    
    UIImage *favoritesImage = [UIImage menuImageWithText:@"Favorites" isUpgrade:NO];
    UIImage *archivesImage  = [UIImage menuImageWithText:@"Archives"      isUpgrade:NO];
    
    UIImage *settingsImage = [UIImage menuImageWithText:@"Account"      isUpgrade:NO];
    
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
    _accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_accountButton setImage:settingsImage forState:UIControlStateNormal];
    _accountButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_accountButton addTarget:self action:@selector(accountAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_accountButton];
    
    //
    [self setupPortriateConstraints];
   // [self setupLandscapeConstraints];
    
    _networkAvailableNotification = [SGNotifications observeNetworkAvailableWithNotification:^(NSNotification *note)
    {
        self.isNetworkAvailable = [note.object boolValue];
        _archivesButton.enabled = self.isNetworkAvailable;
        _booksButton.enabled = self.isNetworkAvailable;
    }];
    
    _archivesButton.enabled = self.isNetworkAvailable;
    _booksButton.enabled = self.isNetworkAvailable;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _accountButton.hidden = ([SGUserDefaults sharedInstance].isUpgraded == NO);

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if(size.width > size.height)
    {
        [self setupLandscapeConstraints];
    }
    else
    {
        [self setupPortriateConstraints];
    }
}

- (void) setupPortriateConstraints
{
    //Latest
    [_latestButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.topLayoutGuide).offset(60);
         make.leading.equalTo(self.view.mas_leading).offset(20);
     }];

    //favorites
    [_favoritesButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_latestButton.mas_bottom);
         make.leading.equalTo(_latestButton.mas_leading);
     }];
    
    //archives
    [_archivesButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_favoritesButton.mas_bottom);
         make.leading.equalTo(_favoritesButton.mas_leading);
     }];
    
    //Books
    [_booksButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_archivesButton.mas_bottom);
         make.leading.equalTo(_archivesButton.mas_leading);
     }];
    
    //Settings
    [_accountButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_booksButton.mas_bottom);
         make.leading.equalTo(_booksButton.mas_leading);
     }];
    
    [UIView animateWithDuration:.2 animations:^{
         [self.view setNeedsLayout];
    }];
   
}

- (void) setupLandscapeConstraints
{
    //Latest
    [_latestButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.topLayoutGuide).offset(60);
         make.leading.equalTo(self.view.mas_leading).offset(20);
     }];
    
    //favorites
    [_favoritesButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_latestButton.mas_top);
         make.trailing.equalTo(_latestButton.mas_trailing);
     }];
    
    //archives
    [_archivesButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_latestButton.mas_bottom);
         make.leading.equalTo(_latestButton.mas_leading);
     }];
    
    //Books
    [_booksButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_archivesButton.mas_top);
         make.trailing.equalTo(_archivesButton.mas_trailing);
     }];
    
    //Settings
    [_accountButton mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(_booksButton.mas_bottom);
         make.centerX.equalTo(self.view.mas_centerX);
     }];
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view setNeedsLayout];
    }];
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

- (void) accountAction:(id) sender
{
    UIViewController *vc;
    
    if(UIDeviceOrientationIsPortrait(self.interfaceOrientation))
    {
       vc = [self.storyboard instantiateViewControllerWithIdentifier:@"account"];
    }
    else
    {
       vc = [self.storyboard instantiateViewControllerWithIdentifier:@"accountLandscape"];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)archivesAction:(id)sender
{
    [self selectArchives];
}

- (void) favoritesAction:(id)sender
{
    [self selectFavorites];
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


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
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
