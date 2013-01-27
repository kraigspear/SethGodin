//
//  SGSignUpViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/19/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGSignUpViewController.h"
#import "UIImage+General.h"

@interface SGSignUpViewController ()

@end

@implementation SGSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.signUpView.logo = [[UIImageView alloc] initWithImage:[UIImage andersonSpearCloudLogo]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
