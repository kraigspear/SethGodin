//
//  SGMenuController_iPad.h
//  SethGodin
//
//  Created by Kraig Spear on 1/10/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockTypes.h"

@interface SGMenuController_iPad : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, copy) SWBasicBlock closeSelected;

@end
