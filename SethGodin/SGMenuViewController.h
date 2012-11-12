//
//  SGMenuViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/12/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockTypes.h"

@interface SGMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *titleBar;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, copy) BasicBlock close;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
