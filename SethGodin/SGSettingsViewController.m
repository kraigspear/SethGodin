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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL isCloud = NO;
    
    if([PFUser currentUser])
    {
        if(![PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]])
        {
            isCloud = YES;
        }
    }
    
    self.cloudSwitch.on = isCloud;
    
	self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"Settings"]];
    
    [self.backButton setImage:[UIImage backButton] forState:UIControlStateNormal];
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

- (IBAction)cloudSyncAction:(id)sender
{
    UISwitch *cloudSwitch = (UISwitch*) sender;
    
    if(cloudSwitch.on)
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
                               });
                           });
        }
    }];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [_loginViewController dismissViewControllerAnimated:YES completion:^
     {
         self.cloudSwitch.on = NO;
     }];
}



@end
