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
#import <Parse/Parse.h>
#import "MBProgressHud.h"

@interface SGSettingsViewController ()

@end

@implementation SGSettingsViewController

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
- (IBAction)loginAction:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Logging In..";
    
    [PFUser logInWithUsernameInBackground:self.loginTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error)
    {
        if(error != nil)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Congrats, you are logged in" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

- (IBAction)newAccountAction:(id)sender
{
    
}


@end
