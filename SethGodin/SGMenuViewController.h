//
//  SGMenuViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/12/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockTypes.h"
#import "SGTitleView.h"



@interface SGMenuViewController : GAITrackedViewController<SGTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleBar;

@property (nonatomic, copy) SWBoolBlock close;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic, assign) BOOL isNetworkAvailable;



@end
