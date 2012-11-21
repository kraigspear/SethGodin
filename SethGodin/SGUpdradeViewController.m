//
//  SGUpdradeViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/21/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGUpdradeViewController.h"
#import "UIImage+General.h"
#import "UIImage+Upgrade.h"
#import "SGUSerDefaults.h"

@interface SGUpdradeViewController ()

@end

@implementation SGUpdradeViewController

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
	self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@""]];
    [self.backButton setImage:[UIImage backButton] forState:UIControlStateNormal];
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage upgradeBackground]];
    [self.upgradeButton setImage:[UIImage upgradeButton] forState:UIControlStateNormal];
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
- (IBAction)upgradeAction:(id)sender
{
    [[SGUserDefaults sharedInstance] setIsUpgraded:YES];
    [self performSegueWithIdentifier:@"upgradeToUpgradedSegue" sender:self];
}

@end
