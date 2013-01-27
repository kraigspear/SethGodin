//
//  SGSettingsViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 12/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SGTitleView.h"

@interface SGAccountViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, SGTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *cloudSyncButton;
@property (weak, nonatomic) IBOutlet UILabel *loggedInUserNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentUserTopConstraint;

@property (nonatomic, assign) BOOL popToRoot;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionHeightConstraint;

@end
