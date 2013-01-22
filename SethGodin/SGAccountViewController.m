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

@interface SGAccountViewController ()

@end

@implementation SGAccountViewController
{
@private
    PFLogInViewController *_loginViewController;
    PFUser                *_oldUser;
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
    
    NSString *userName;
    
    if(isGuest)
    {
        userName = @"Guest";
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
    [self.descriptionLabel sizeToFit];
    [self.view layoutSubviews];
}

- (void) updateViewForOrientation:(UIInterfaceOrientation) inOrientation
{
    if(UIDeviceOrientationIsPortrait(inOrientation))
    {
        self.descriptionLabel.numberOfLines = 3;
        self.currentUserTopConstraint.constant = 121;
    }
    else
    {
        self.descriptionLabel.numberOfLines = 2;
        self.currentUserTopConstraint.constant = 90;
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

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText = @"Updating favorites...";
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                           {
                               [SGFavoritesParse moveUserDataToCurrentUserFor:_oldUser];
                               
                               dispatch_async(dispatch_get_main_queue(), ^
                               {
                                   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                               });
                           });
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
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"ACCOUNT";
}

- (UIImage*) leftButtonImage
{
    return [UIImage backButtonWithColor:[UIColor menuTitleBarTextColor]];
}

- (void) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
