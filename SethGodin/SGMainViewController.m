//
//  SGMainViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/7/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGMainViewController.h"

@interface SGMainViewController ()

@end

@implementation SGMainViewController

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
	
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    [self addBlogEntriesViewUsingStoryBoard:storyboard];
    [self addBlogEntryViewUsingStoryBoard:storyboard];
    
}

- (void) addBlogEntryViewUsingStoryBoard:(UIStoryboard*) inBoard
{
    UIViewController *vc = [inBoard instantiateViewControllerWithIdentifier:@"blogEntry"];
    
    self.rightView = vc.view;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [self.rightView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSLayoutConstraint *topConstraint =
	[NSLayoutConstraint
     constraintWithItem:self.rightView
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeTop
     multiplier:1.0f
     constant:0.0f];
    
    NSLayoutConstraint *bottomConstraint =
	[NSLayoutConstraint
     constraintWithItem:self.rightView
     attribute:NSLayoutAttributeBottom
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeBottom
     multiplier:1.0f
     constant:0.0f];
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint constraintWithItem:self.rightView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.leftView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                  constant:0.0f];
    
    NSLayoutConstraint *trailingConstraint =
    [NSLayoutConstraint constraintWithItem:self.rightView
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
    UIViewController *vc = [inBoard instantiateViewControllerWithIdentifier:@"blogEntries"];
    
    self.leftView = vc.view;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [self.leftView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *topConstraint =
	[NSLayoutConstraint
     constraintWithItem:self.leftView
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeTop
     multiplier:1.0f
     constant:0.0f];
    
    NSLayoutConstraint *bottomConstraint =
	[NSLayoutConstraint
     constraintWithItem:self.leftView
     attribute:NSLayoutAttributeBottom
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeBottom
     multiplier:1.0f
     constant:0.0f];
    
    
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:self.leftView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:320.0f];
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint constraintWithItem:self.leftView
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

@end
