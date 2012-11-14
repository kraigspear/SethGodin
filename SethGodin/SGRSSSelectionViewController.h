//
//  SGViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGRSSSelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property (weak, nonatomic) IBOutlet UIButton *rssItem1Button;
@property (weak, nonatomic) IBOutlet UIButton *rssItem2Button;
@property (weak, nonatomic) IBOutlet UIButton *rssItem3Button;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundLoading;


@end
