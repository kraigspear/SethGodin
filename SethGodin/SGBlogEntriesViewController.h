//
//  SGViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockTypes.h"


/**
 Shows a list of BlogEntries
 Task
 1. Show blog entries for the current users selection
    Example: Current, Favorite, Archives
 2. Allows selection of a BlogItem, which is then viewed in a SGBlogEntryViewController 
 */
@interface SGBlogEntriesViewController : GAITrackedViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonViewToTopViewConstraint;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic, assign) BOOL isNetworkingAvailable;

@property (nonatomic, copy) SWBasicBlock menuSelected;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewToTopViewConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
