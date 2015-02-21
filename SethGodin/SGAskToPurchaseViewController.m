//
//  SGAskToPurchaseViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/13/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGAskToPurchaseViewController.h"
#import "SGUSerDefaults.h"
#import "UIImage+Upgrade.h"

NSString * const TITLE_SUCCESS = @"Success";

@interface SGAskToPurchaseViewController ()

@end

@implementation SGAskToPurchaseViewController
{
@private
    SGInAppPurchase *_inappPurchase;
    UIAlertView     *_alertView;
    UITapGestureRecognizer *_parentTapGesture;
}

- (id) init
{
    self = [self initWithNibName:@"AskToPurchase" bundle:nil];
    
    if(self)
    {
        
    }
    
    return self;
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
	[self.purchaseButton setImage:[UIImage upgradeButton] forState:UIControlStateNormal];
    
    _parentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(parentViewTap:)];
    
    _parentTapGesture.cancelsTouchesInView = NO;
    [self.presentingViewController.view.window addGestureRecognizer:_parentTapGesture];
    
    NSLog(@"%@", self.presentingViewController);
}

- (void) cleanUp
{
    [self.presentingViewController.view.window removeGestureRecognizer:_parentTapGesture];
    _parentTapGesture = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) parentViewTap:(UITapGestureRecognizer*) inGesture
{
    if (inGesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [inGesture locationInView:nil];
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil])
        {
            [self cleanUp];            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alreadyUpgradedAction:(id)sender
{
    _inappPurchase = [SGInAppPurchase sharedInstance];
    _inappPurchase.delegate = self;
    [_inappPurchase restorePurchases];
}

- (IBAction)upgradeAction:(id)sender
{
    _inappPurchase = [SGInAppPurchase sharedInstance];
    _inappPurchase.delegate = self;
    [_inappPurchase purchaseUpgrade];
}

#pragma mark -
#pragma mark SGInAppPurchaseDelegate

- (void) purchaseCompleteWithID:(NSString*) inId
{
    _alertView = [[UIAlertView alloc] initWithTitle:TITLE_SUCCESS message:@"Awesome! You're officially upgraded." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [_alertView show];
    _inappPurchase = nil;
}

- (void) didFailWithError:(NSError*) inError
{
    _alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:inError.localizedDescription delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    _alertView.delegate = self;
    
    [_alertView show];
    
    _inappPurchase = nil;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    _alertView = nil;
    
    if([alertView.title isEqualToString:TITLE_SUCCESS])
    {
        [self cleanUp];
    }
}


@end
