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
#import "SGUpgradedViewController.h"
#import "Flurry.h"
#import "UIColor+General.h"
#import "UIImage+General.h"

@interface SGUpdradeViewController ()

@end

@implementation SGUpdradeViewController
{
@private
    UIAlertView *_alertView;
    SGInAppPurchase *_inappPurchase;
}

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
    [self.upgradeButton setImage:[UIImage upgradeButton] forState:UIControlStateNormal];
    [self updateConstraintsForOrientation:self.interfaceOrientation];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if([SGUserDefaults sharedInstance].isUpgraded)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self updateConstraintsForOrientation:toInterfaceOrientation];
}

- (void) updateConstraintsForOrientation:(UIDeviceOrientation) inOrientation
{
    if(UIDeviceOrientationIsPortrait(inOrientation))
    {
        self.upgradeMessageTopConstraint.constant = 100;
        self.upgradeMessageHeightConstraint.constant = 127;
    }
    else
    {
        self.upgradeMessageTopConstraint.constant = 20;
        self.upgradeMessageHeightConstraint.constant = 60;
    }
    
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _inappPurchase = nil;
    _alertView = nil;
}


- (IBAction)upgradeAction:(id)sender
{
    _inappPurchase = [SGInAppPurchase sharedInstance];
    _inappPurchase.delegate = self;
    [_inappPurchase purchaseUpgrade];
}


#pragma mark -
#pragma mark SGInAppPurchaseDelegate


- (void) purchaseCompleteWithID:(NSString*)inId
{
    [Flurry logEvent:@"Purchased"];
    _inappPurchase = nil;
    [self performSegueWithIdentifier:@"upgradeToUpgradedSegue" sender:nil];
}

- (void) didFailWithError:(NSError*) inError
{
    _alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:inError.localizedDescription delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    _alertView.delegate = self;
    
    [_alertView show];
    
    [Flurry logError:@"Purchase" message:@"Purchase failed" error:inError];
    
    _inappPurchase = nil;
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    _alertView = nil;
}

- (IBAction)alreadyUpgradedAction:(id)sender
{
    _inappPurchase = [SGInAppPurchase sharedInstance];
    _inappPurchase.delegate = self;
    [_inappPurchase restorePurchases];
}

#pragma mark -
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"UPGRADE";
}

- (UIImage*) leftButtonImage
{
    return [UIImage backButtonWithColor:[UIColor menuTitleBarTextColor]];
}

- (void) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIColor*) titleTextColor
{
    return [UIColor menuTitleBarTextColor];
}

- (UIColor*)  titleViewBackgroundColor
{
    return [UIColor menuTitleBarBackgroundColor];
}


@end
