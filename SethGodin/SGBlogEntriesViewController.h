//
//  SGViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Shows a list of BlogEntries
 Task
 1. Show blog entries for the current users selection
    Example: Current, Favorite, Archives
 2. Allows selection of a BlogItem, which is then viewed in a SGBlogEntryViewController 
 */
@interface SGBlogEntriesViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property (weak, nonatomic) IBOutlet UIButton *rssItem1Button;
@property (weak, nonatomic) IBOutlet UIButton *rssItem2Button;
@property (weak, nonatomic) IBOutlet UIButton *rssItem3Button;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonViewToTopViewConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonViewToLeftButtonViewConstraint;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic, assign) BOOL isNetworkingAvailable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button1HeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button2HeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *button3HeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftButtonHeightConstraint;



@end
