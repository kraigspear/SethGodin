//
//  SGMainViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 1/7/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGMenuController_iPad.h"

@interface SGMainViewController_ipad : UIViewController<SGMenuController_iPadDelegate>

+ (SGMainViewController_ipad*) sharedInstance;

@end
