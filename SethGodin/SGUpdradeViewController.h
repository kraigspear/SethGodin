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

@interface SGUpdradeViewController : UIViewController <SGInAppPurchaseDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UIButton *upgradeButton;


@end
