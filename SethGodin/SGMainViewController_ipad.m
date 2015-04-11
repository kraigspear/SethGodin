//
//  SGMainViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/7/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGMainViewController_ipad.h"
#import "SGBlogEntriesViewController.h"
#import "SGBlogEntryViewController.h"
#import "SGNotifications.h"
#import "SGBookPurchaseViewController.h"
#import "SGArchiveSelectionViewController.h"
#import <Parse/Parse.h>


#define MENU_HEIGHT 336
#define LEFT_VIEW_WIDTH 320.0f

@interface SGMainViewController_ipad ()

@end

@implementation SGMainViewController_ipad
{
@private
    __weak SGMenuController_iPad        *_menuController;
    __weak SGBlogEntriesViewController  *_blogEntriesViewController;
    __weak SGBlogEntryViewController    *_blogEntryViewController;
    
    __weak UIViewController          *_upperViewController;
    
    NSLayoutConstraint               *_bogEntryTopConstraintNoMenu;
    NSLayoutConstraint               *_blogEntryTopConstraitWithMenu;
    
    NSLayoutConstraint               *_upperViewLeadingConstriant;
    NSLayoutConstraint               *_upperViewTrailingConstraint;
    
    NSLayoutConstraint               *_menuTopConstraint;
    
    UIStoryboard                     *_iphoneStoryBoard;
    
    id                               _feedSelectionNotification;
    id                               _menuSelectedNotification;
    
}

static SGMainViewController_ipad *instance;

+ (SGMainViewController_ipad*) sharedInstance
{
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        instance = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    instance = self;
    
    _iphoneStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    [self addBlogEntriesView];
    [self addBlogEntryView];
    
    _feedSelectionNotification = [SGNotifications observeFeedSelectionWithNotification:^(NSNotification *notification)
    {
        SGFeedSelection *feedSelection = notification.object;
        if(feedSelection.feedType == kArchive)
        {
            [self hideLeftView];
        }
    }];
    
    _menuSelectedNotification = [SGNotifications observeMenuSelectedNotification:^(NSNotification *notification)
    {
        NSNumber *boolNumber = notification.object;
        BOOL isSelected = [boolNumber boolValue];
        
        if(!isSelected)
        {
            [self hideMenu];
        }
        
    }];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(![PFUser currentUser])
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"account"];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:vc animated:YES completion:nil];
    }
}


- (void) addBlogEntryView
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"blogEntry"];
    
    _blogEntryViewController = (SGBlogEntryViewController*) vc;
    
    UIView *rightView = vc.view;
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [rightView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    _bogEntryTopConstraintNoMenu = 
	[NSLayoutConstraint
     constraintWithItem:rightView
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeTop
     multiplier:1.0f
     constant:0.0f];
    
    NSLayoutConstraint *bottomConstraint =
	[NSLayoutConstraint
     constraintWithItem:rightView
     attribute:NSLayoutAttributeBottom
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeBottom
     multiplier:1.0f
     constant:0.0f];
    
    NSAssert(_blogEntriesViewController != nil, @"BlogEntries should be setup before BlogEntry");
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint constraintWithItem:rightView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_blogEntriesViewController.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                  constant:0.0f];
    
    NSLayoutConstraint *trailingConstraint =
    [NSLayoutConstraint constraintWithItem:rightView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                  constant:0.0f];
    
    [self.view addConstraints:@[_bogEntryTopConstraintNoMenu, bottomConstraint, leadingConstraint, trailingConstraint]];
    
    
    //SGBlogEntryViewController
}

- (void) addBlogEntriesView
{
    SGBlogEntriesViewController *vc = (SGBlogEntriesViewController*) [_iphoneStoryBoard instantiateViewControllerWithIdentifier:@"blogEntries"];
    
    _blogEntriesViewController = vc;
    
    vc.menuSelected = ^
    {
        [self menuSelected];
    };
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    UIView *leftView = vc.view;
    
    [vc.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *topConstraint =
	[NSLayoutConstraint
     constraintWithItem:leftView
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeTop
     multiplier:1.0f
     constant:0.0f];
    
    NSLayoutConstraint *bottomConstraint =
	[NSLayoutConstraint
     constraintWithItem:leftView
     attribute:NSLayoutAttributeBottom
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeBottom
     multiplier:1.0f
     constant:0.0f];
    
    
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:leftView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:LEFT_VIEW_WIDTH];
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint constraintWithItem:leftView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0f
                                  constant:0.0f];
    
    [self.view addConstraints:@[topConstraint, bottomConstraint, widthConstraint, leadingConstraint]];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark menu
- (void) menuSelected
{
    if(_menuController)
    {
        [self hideMenu];
    }
    else
    {
        [self showMenu];
    }
}

- (void) showMenu
{
    SGMenuController_iPad *vc = (SGMenuController_iPad*) [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    
    _menuController = vc;
    _menuController.delegate = self;
    _blogEntriesViewController.menuButton.hidden = YES;
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [self setupMenuViewConstraints];
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^
    {
        _menuTopConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }
    completion:^(BOOL completed)
     {
         
     }];
}

- (void) setupMenuViewConstraints
{
    UIViewController *vc = _menuController;
    
    UIView *parentView     = _blogEntryViewController.view;
    
    UIView *menuView   = vc.view;
    
    [menuView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSAssert(_blogEntryViewController != nil, @"Can't setup the menu without BlogEntry, it's the parent");
    
    _menuTopConstraint =
    [NSLayoutConstraint constraintWithItem:menuView
                        attribute:NSLayoutAttributeTop
                        relatedBy:NSLayoutRelationEqual
                        toItem:self.view
                        attribute:NSLayoutAttributeTop
                        multiplier:1
                        constant:-MENU_HEIGHT];
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint constraintWithItem:menuView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_blogEntriesViewController.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint *trailingConstraint =
    [NSLayoutConstraint constraintWithItem:menuView
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint *heightConstraint =
    [NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:MENU_HEIGHT];
    
    //Constriant to move down the blog entry view. The menu now becomes the top view.
    _blogEntryTopConstraitWithMenu =
    [NSLayoutConstraint constraintWithItem:_blogEntryViewController.view
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:menuView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0];
    
    
    
    [self.view removeConstraint:_bogEntryTopConstraintNoMenu];
    
    [self.view addConstraints:@[_menuTopConstraint, heightConstraint, leadingConstraint, trailingConstraint, _blogEntryTopConstraitWithMenu]];
    
}

- (void) hideMenu
{
    [self hideLeftView];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^
     {
         _menuTopConstraint.constant = -MENU_HEIGHT;
         [self.view layoutIfNeeded];
     }
     completion:^(BOOL success)
     {
         [self.view removeConstraint:_blogEntryTopConstraitWithMenu];
         [self.view addConstraint:_bogEntryTopConstraintNoMenu];
         _blogEntriesViewController.menuButton.hidden = NO;
         [_menuController.view removeFromSuperview];
         [_menuController removeFromParentViewController];
         _menuController = nil;
         [self.view layoutIfNeeded];
     }];
}

- (void) hideLeftView
{
    if(_upperViewController)
    {
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^
         {
             _upperViewLeadingConstriant.constant = -LEFT_VIEW_WIDTH;
             _upperViewTrailingConstraint.constant = -LEFT_VIEW_WIDTH;
             [self.view layoutIfNeeded];
         } completion:^(BOOL finished)
         {
             [self cleanUpUpperViewController];
         }];
    }
}

- (void) cleanUpUpperViewController
{
    [_upperViewController.view removeFromSuperview];
    [_upperViewController removeFromParentViewController];
    _upperViewController = nil;
}

#pragma mark -
#pragma mark SGMenuController_iPadDelegate

- (void) closeSelected:(id)sender
{
    [self hideLeftView];
    [self hideMenu];
}

- (void) latestSelected:(id)sender
{
    [self hideLeftView];
}

- (void) archiveSelected:(id) sender
{
    
    if(_upperViewController)
    {
        if([_upperViewController isKindOfClass:[SGArchiveSelectionViewController class]])
        {
            return;
        }
    }
    
    [self cleanUpUpperViewController];

    SGArchiveSelectionViewController *archiveViewController = (SGArchiveSelectionViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"archives"];
    
    _upperViewController = archiveViewController;
    UIView *archiveView  = archiveViewController.view;
    [self addChildViewController:archiveViewController];
    [self.view addSubview:archiveView];
    archiveView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[self constraintsForUpperViewController:archiveView]];
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^
    {
        _upperViewLeadingConstriant.constant = 0;
        _upperViewTrailingConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished)
    {
        
    }];
}

- (NSArray*) constraintsForUpperViewController:(UIView*) inView
{
    NSLayoutConstraint *topConstraint =
    [NSLayoutConstraint constraintWithItem:inView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_blogEntriesViewController.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    _upperViewLeadingConstriant =
    [NSLayoutConstraint constraintWithItem:inView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_blogEntriesViewController.view attribute:NSLayoutAttributeLeading multiplier:1 constant:-LEFT_VIEW_WIDTH];
    
    _upperViewTrailingConstraint =
    [NSLayoutConstraint constraintWithItem:inView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_blogEntriesViewController.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-LEFT_VIEW_WIDTH];
    
    NSLayoutConstraint *botomConstraint = [NSLayoutConstraint constraintWithItem:inView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_blogEntriesViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    return @[topConstraint, _upperViewLeadingConstriant, _upperViewTrailingConstraint, botomConstraint];
}

- (void) favoritesSelected:(id)sender
{
    [self hideLeftView];
}

- (void) booksSelected:(id)sender
{
    if(_upperViewController)
    {
        if([_upperViewController isKindOfClass:[SGBookPurchaseViewController class]])
        {
            return;
        }
    }
    
    [self cleanUpUpperViewController];
    
    SGBookPurchaseViewController *booksViewController = [_iphoneStoryBoard instantiateViewControllerWithIdentifier:@"books"];
    
    booksViewController.verticalMode = YES;
    
    _upperViewController = booksViewController;
    UIView *booksView = booksViewController.view;
    [self addChildViewController:booksViewController];
    [self.view addSubview:booksView];
    booksView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[self constraintsForUpperViewController:booksView]];
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^
     {
         _upperViewLeadingConstriant.constant = 0;
         _upperViewTrailingConstraint.constant = 0;
         [self.view layoutIfNeeded];
     } completion:^(BOOL finished)
     {
         
     }];

}

@end
