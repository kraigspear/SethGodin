//
//  SGSettingsViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 12/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGAccountViewController.h"
#import "SGFavoritesParse.h"
#import "SGLoginViewController.h"
#import "SGSignUpViewController.h"
#import "SGAppDelegate.h"
#import "UIImage+Account.h"
#import "SGFavorites.h"
#import "UIScreen+Util.h"
#import "Seth_Godin-Swift.h"
#import "SethGodinStyleKit.h"

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

 
- (BOOL)shouldAutorotate
{
    return NO;
}


- (NSString*) userName
{
    if(![PFUser currentUser]) return @"";
    
    if([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) return @"Guest";
    
    return [PFUser currentUser].username;
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
    
    self.view.backgroundColor =  [UIColor colorWithPatternImage:[UIImage backgroundImageForUserSignedIn:[self userName] atOrientation:self.interfaceOrientation]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateButtonImages];
}

- (void) updateButtonImages
{
    if(self.signInButton.frame.size.height == 0) return;
}

- (void) viewDidLayoutSubviews
{
    if(self.signInButton.frame.size.height == 0) return;
    
    UIImage *signInImage = [SethGodinStyleKit imageOfStandardButtonWithFrame:CGRectMake(0, 0, self.signInButton.frame.size.width, self.signInButton.frame.size.height) text:@"SIGN IN"];
    
    UIImage *accountImage = [SethGodinStyleKit imageOfStandardButtonWithFrame:CGRectMake(0, 0, self.signInButton.frame.size.width, self.signInButton.frame.size.height) text:@"CREATE ACCOUNT"];

    [self.signInButton setImage:signInImage forState:UIControlStateNormal];
    [self.createAccountButton  setImage:accountImage forState:UIControlStateNormal];
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
        [self didLogInUser];
    }];
}

- (void) didLogInUser
{
    if(_oldUser)
    {
        if([PFAnonymousUtils isLinkedWithUser:_oldUser])
        {
            [SGFavoritesParse moveUserDataToCurrentUserFor:_oldUser];
        }
    }
    
    [self exportToParse];
    
    if(IS_IPHONE)
    {
        if(_popToRoot)
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self dismissAccountViewController];
    }

}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [_loginViewController dismissViewControllerAnimated:YES completion:^
     {
         [self createGuestUser];
     }];
}

- (void) createGuestUser
{
    if(![PFUser currentUser])
    {
        [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error)
         {
             if (error)
             {
             }
             else
             {
                 [self exportToParse];
             }
         }];
    }
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
     [signUpController dismissViewControllerAnimated:YES completion:^
     {
         [self didLogInUser];
     }];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark login sign up actions

- (IBAction)skipForNowAction:(id)sender
{
    [self createGuestUser];
    
    if(IS_IPAD)
    {
        [self dismissAccountViewController];
    }
    else
    {
        if(!self.navigationController)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
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

}

- (IBAction)createAccountAction:(id)sender
{
    _oldUser = [PFUser currentUser];
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
    | PFLogInFieldsPasswordForgotten
    | PFLogInFieldsDismissButton
    ;
    
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
            [self dismissAccountViewController];
        }
    }
}

- (void) dismissAccountViewController
{
    [_gestureWindow removeGestureRecognizer:_tapGestureRecognizer];
    _tapGestureRecognizer = nil;
    _loginViewController = nil;
    _oldUser = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) exportToParse
{
    if([SGFavorites favoritesFileExist])
    {
        [SGFavoritesParse exportFavoritesToParse];
    }
}


@end
