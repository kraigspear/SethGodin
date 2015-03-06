//
//  SGLoginViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/19/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGLoginViewController.h"
#import "SGSignUpViewController.h"
#import "SethGodinStyleKit.h"
#import "UIColor+General.h"

@interface SGLoginViewController ()

@end

@implementation SGLoginViewController

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

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"SETH GODIN'S BLOG";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:30];
    titleLabel.textColor = [UIColor whiteColor];
    self.logInView.logo = titleLabel;
    self.logInView.backgroundColor = [UIColor accountBackgroundColor];
    UIImage *buttonImage = [SethGodinStyleKit imageOfGreenBackground];
    [self.logInView.logInButton setBackgroundImage:buttonImage forState:UIControlStateNormal];

    self.signUpController = [[SGSignUpViewController alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
