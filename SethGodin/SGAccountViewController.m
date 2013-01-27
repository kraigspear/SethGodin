//
//  SGSettingsViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 12/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGAccountViewController.h"
#import "UIImage+General.h"
#import "SGUSerDefaults.h"
#import "SGFavoritesParse.h"
#import "MBProgressHud.h"
#import "SGLoginViewController.h"
#import "SGSignUpViewController.h"
#import "UIColor+General.h"
#import "UIImage+General.h"
#import "SGAppDelegate.h"

@interface SGAccountViewController ()

@end

@implementation SGAccountViewController
{
@private
    PFLogInViewController *_loginViewController;
    PFUser                *_oldUser;
    
    __weak UIWindow        *_gestureWindow;
    UITapGestureRecognizer *_tapGestureRecognizer;
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

- (void)updateLogInUserLabel
{
    BOOL isCloud = NO;
    
    if([PFUser currentUser])
    {
        if(![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]])
        {
            isCloud = YES;
        }
    }
    
    BOOL isGuest = [PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]];
    BOOL isTwitter = [PFTwitterUtils isLinkedWithUser:[PFUser currentUser]];
    BOOL isFacebook = [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]];
    
    NSString *userName;
    
    if(isGuest)
    {
        userName = @"Guest";
    }
    else if(isTwitter)
    {
        userName = @"Twitter";
    }
    else if(isFacebook)
    {
        userName = @"Facebook";
    }
    else
    {
        userName = [PFUser currentUser].username;
    }
    
    self.loggedInUserNameLabel.text = [NSString stringWithFormat:@"Login: %@", userName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_IPAD)
    {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(parentViewTap:)];
        
        _tapGestureRecognizer.cancelsTouchesInView = NO;
        
        _gestureWindow = [[SGAppDelegate instance] window];
        
        [_gestureWindow addGestureRecognizer:_tapGestureRecognizer];
    }
    
    [self updateLogInUserLabel];
    
    UIImage *logInImage = [UIImage orangeButtonWithSize:CGSizeMake(280, 44) text:@"Log In"];
    
    [self.loginButton setImage:logInImage forState:UIControlStateNormal];
    
    UIImage *createAccountImage = [UIImage orangeButtonWithSize:CGSizeMake(280, 44) text:@"Create Account"];
    
    [self.createAccountButton setImage:createAccountImage forState:UIControlStateNormal];
    
    [self updateViewForOrientation:self.interfaceOrientation];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self updateViewForOrientation:toInterfaceOrientation];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    if(IS_IPHONE)
    {
        [UIView animateWithDuration:.2 animations:^
        {
            if(UIDeviceOrientationIsPortrait(self.interfaceOrientation))
            {
                self.descriptionHeightConstraint.constant = 96;
            }
            else
            {
                self.descriptionHeightConstraint.constant = 64;
            }
            
            [self.view layoutIfNeeded];
        }];
    }
}

- (void) updateViewForOrientation:(UIInterfaceOrientation) inOrientation
{
    
    if(IS_IPHONE)
    {
        if(UIDeviceOrientationIsPortrait(self.interfaceOrientation))
        {
            self.descriptionHeightConstraint.constant = 96;
        }
        else
        {
            self.descriptionHeightConstraint.constant = 64;
        }
        
        [self.view layoutIfNeeded];
    }

}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateButtonImages];
}

- (void) updateButtonImages
{
    if(self.loginButton.frame.size.height == 0) return;
}

- (void) viewDidLayoutSubviews
{
    NSLog(@"loginButtonSize = %f", self.loginButton.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PFLogInViewControllerDelegate

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user
{
    [_loginViewController dismissViewControllerAnimated:YES completion:^
    {
        [self updateLogInUserLabel];
        if([PFAnonymousUtils isLinkedWithUser:_oldUser])
        {
            [SGFavoritesParse moveUserDataToCurrentUserFor:_oldUser];
        }
    }];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [_loginViewController dismissViewControllerAnimated:YES completion:^
     {
         
     }];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
     [signUpController dismissViewControllerAnimated:YES completion:^
     {
         [self updateLogInUserLabel];
     }];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark login sign up actions

- (IBAction)createAccountAction:(id)sender
{
    SGSignUpViewController *signUpViewController = [[SGSignUpViewController alloc] init];
    signUpViewController.delegate = self;
    [self presentViewController:signUpViewController animated:YES completion:nil];
}

- (IBAction)logInAction:(id)sender
{
    _oldUser = [PFUser currentUser];
    
    _loginViewController = [[SGLoginViewController alloc] init];
    
    _loginViewController.fields = PFLogInFieldsUsernameAndPassword
    | PFLogInFieldsLogInButton
    | PFLogInFieldsSignUpButton
    | PFLogInFieldsPasswordForgotten
    | PFLogInFieldsDismissButton
    | PFLogInFieldsFacebook
    | PFLogInFieldsTwitter;
    
    
    _loginViewController.delegate = self;
    [self presentViewController:_loginViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark TapGesture

- (void) parentViewTap:(UITapGestureRecognizer*) inGesture
{
    if (inGesture.state == UIGestureRecognizerStateEnded)
    {
        //We are getting all taps, so we need to make sure the tap is not in the model      view.
        CGPoint location = [inGesture locationInView:nil];
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil])
        {
            [self cleanUpTap];
        }
    }
}

- (void) cleanUpTap
{
    [_gestureWindow removeGestureRecognizer:_tapGestureRecognizer];
    _tapGestureRecognizer = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"ACCOUNT";
}

- (UIImage*) leftButtonImage
{
    if(IS_IPAD)
    {
        return [UIImage closeButtonWithColor:[UIColor menuTitleBarTextColor]];
    }
    else
    {
        return [UIImage backButtonWithColor:[UIColor menuTitleBarTextColor]];
    }
    
}

- (void) leftButtonAction:(id)sender
{
    if(IS_IPAD)
    {
        [self cleanUpTap];
    }
    else
    {
        
        if(self.popToRoot)
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
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
