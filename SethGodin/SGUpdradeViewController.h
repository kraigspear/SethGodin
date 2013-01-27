//
//  SGUpdradeViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/21/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockTypes.h"
#import "SGInAppPurchase.h"
#import "SGTitleView.h"

@interface SGUpdradeViewController : UIViewController <SGInAppPurchaseDelegate>

@property (weak, nonatomic) IBOutlet SGTitleView *topView;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UIButton *upgradeButton;

/**
 Where to popback if the user purchases the upgrade
 */
@property (weak, nonatomic) UIViewController *popbackViewController;

@end
