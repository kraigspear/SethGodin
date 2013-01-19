//
//  SGLoginViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/19/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGLoginViewController.h"
#import "UIImage+General.h"
#import "SGSignUpViewController.h"

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
    self.signUpController = [[SGSignUpViewController alloc] init];
    self.logInView.logo = [[UIImageView alloc] initWithImage:[UIImage andersonSpearCloudLogo]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
