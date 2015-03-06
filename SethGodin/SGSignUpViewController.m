//
//  SGSignUpViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/19/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGSignUpViewController.h"
#import "UIImage+General.h"
#import "UIColor+General.h"
#import "UIImage+Account.h"
#import "SethGodinStyleKit.h"

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
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"SETH GODIN'S BLOG";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:30];
    titleLabel.textColor = [UIColor whiteColor];
    
    self.signUpView.logo = titleLabel;
    
    self.signUpView.backgroundColor = [UIColor colorWithRed:1.000 green:0.600 blue:0.000 alpha:1];
    
    UIImage *buttonImage = [SethGodinStyleKit imageOfGreenBackground];
    
    [self.signUpView.signUpButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    //222,48
    
    //self.view.backgroundColor = [UIColor blogEntryTitleBackgroundColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
