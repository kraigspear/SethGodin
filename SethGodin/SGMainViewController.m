//
//  SGMainViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/7/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGMainViewController.h"
#import "SGBlogEntriesViewController.h"

@interface SGMainViewController ()

@end

@implementation SGMainViewController
{
@private
    __weak UIViewController *_menuController;
    __weak UIViewController *_blogEntriesViewController;
    __weak UIViewController *_blogEntryViewController;
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
    
    _blogEntryViewController = vc;
    
    UIView *rightView = vc.view;
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [rightView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSLayoutConstraint *topConstraint =
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
    
    [self.view addConstraints:@[topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]];
    
    
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
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    _menuController = vc;
    
    [_blogEntryViewController addChildViewController:vc];
    [_blogEntryViewController.view addSubview:vc.view];
    
    [self.view layoutIfNeeded];
}

- (void) setupMenuViewConstraints
{
    UIViewController *vc = _menuController;
    
    [vc.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSAssert(_blogEntryViewController != nil, @"Can't setup the menu without BlogEntry, it's the parent");
    
    UIView *rightView = _blogEntryViewController.view;
    
    NSLayoutConstraint *topConstraint =
	[NSLayoutConstraint
     constraintWithItem:vc.view
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:rightView
     attribute:NSLayoutAttributeBottom
     multiplier:1.0f
     constant:50.0f];
    
    NSLayoutConstraint *heightConstraint =
    [NSLayoutConstraint constraintWithItem:vc.view
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:200.0f];
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint constraintWithItem:vc.view
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:rightView
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0f
                                  constant:50.0f];
    
    NSLayoutConstraint *trailingConstraint =
    [NSLayoutConstraint constraintWithItem:vc.view
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:rightView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                  constant:10.0f];
    
    [self.view addConstraints:@[topConstraint, heightConstraint, leadingConstraint, trailingConstraint]];
}

- (void) hideMenu
{
    [_menuController.view removeFromSuperview];
    [_menuController removeFromParentViewController];
    _menuController = nil;
}



@end
