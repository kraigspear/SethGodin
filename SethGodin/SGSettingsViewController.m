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
    
    self.useICloudSwitch.on = [[SGUserDefaults sharedInstance] useICloud];

}

- (IBAction)useICloudAction:(id)sender
{
    [[SGUserDefaults sharedInstance] setUseICloud:self.useICloudSwitch.on];
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

@end
