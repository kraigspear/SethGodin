//
//  SGAskToPurchaseViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 1/13/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGInAppPurchase.h"

@interface SGAskToPurchaseViewController : UIViewController <SGInAppPurchaseDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;

@end
