//
//  SGMainViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/7/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGMainViewController.h"
#import "SGBlogEntriesViewController.h"
#import "SGBlogEntryViewController.h"
#import "SGMenuController_iPad.h"

#define MENU_HEIGHT 225

@interface SGMainViewController ()

@end

@implementation SGMainViewController
{
@private
    __weak SGMenuController_iPad     *_menuController;
    __weak UIViewController          *_blogEntriesViewController;
    __weak SGBlogEntryViewController *_blogEntryViewController;
    
    NSLayoutConstraint               *_bogEntryTopConstraintNoMenu;
    NSLayoutConstraint               *_blogEntryTopConstraitWithMenu;
    
    NSLayoutConstraint               *_menuTopConstraint;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    [self addBlogEntriesViewUsingStoryBoard:storyboard];
    [self addBlogEntryViewUsingStoryBoard:storyboard];
    
}

- (void) addBlogEntryViewUsingStoryBoard:(UIStoryboard*) inBoard
{
    UIViewController *vc = [inBoard instantiateViewControllerWithIdentifier:@"blogEntry"];
    
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

- (void) addBlogEntriesViewUsingStoryBoard:(UIStoryboard*) inBoard
{
    SGBlogEntriesViewController *vc = (SGBlogEntriesViewController*) [inBoard instantiateViewControllerWithIdentifier:@"blogEntries"];
    
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
                                  constant:320.0f];
    
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
    
    _menuController.closeSelected = ^
    {
        [self hideMenu];
    };
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [self setupMenuViewConstraints];
    [self.view layoutIfNeeded];
    
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^
    {
        _menuTopConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }
    completion:nil];
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
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseOut animations:^
     {
         _menuTopConstraint.constant = -MENU_HEIGHT;
         [self.view layoutIfNeeded];
     }
     completion:^(BOOL success)
     {
         [self.view removeConstraint:_blogEntryTopConstraitWithMenu];
         [self.view addConstraint:_bogEntryTopConstraintNoMenu];
         _menuController.closeSelected = nil;
         [_menuController.view removeFromSuperview];
         [_menuController removeFromParentViewController];
         _menuController = nil;
         [self.view layoutIfNeeded];
     }];
}



@end
