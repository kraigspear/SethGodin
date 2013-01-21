//
//  SGSettingsViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 12/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGSettingsViewController.h"
#import "UIImage+General.h"
#import "SGUSerDefaults.h"
#import "SGFavoritesParse.h"
#import "MBProgressHud.h"
#import "SGLoginViewController.h"
#import "SGSignUpViewController.h"

@interface SGSettingsViewController ()

@end

@implementation SGSettingsViewController
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
    
    if(isGuest)
    {
        self.loggedInUserNameLabel.text = @"Guest";
    }
    else
    {
        self.loggedInUserNameLabel.text = [PFUser currentUser].username;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateLogInUserLabel];
    
	self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"Settings"]];
    
    UIImage *logInImage = [UIImage settingsButtonImageWithText:@"Log In" size:CGSizeMake(280, 44)];
    [self.loginButton setImage:logInImage forState:UIControlStateNormal];
    
    UIImage *createAccountImage = [UIImage settingsButtonImageWithText:@"Create Account" size:CGSizeMake(280, 44)];
    
    [self.createAccountButton setImage:createAccountImage forState:UIControlStateNormal];
    
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
                                   self.loggedInUserNameLabel.text = user.username;
                                   [self updateLogInUserLabel];
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

@end
