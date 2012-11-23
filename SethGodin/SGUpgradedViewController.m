//
//  SGUpgradedViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/21/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGUpgradedViewController.h"
#import "UIImage+Upgrade.h"

@interface SGUpgradedViewController ()

@end

@implementation SGUpgradedViewController



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
	self.view.backgroundColor = [UIColor colorWithRed:0.620 green:0.765 blue:0.294 alpha:1];
    [self.thankYouButton setImage:[UIImage thankYouButton] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)thankYouAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
