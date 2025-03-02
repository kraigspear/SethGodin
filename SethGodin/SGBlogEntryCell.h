//
//  SGBlogEntryCell.h
//  SethGodin
//
//  Created by Kraig Spear on 1/6/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "GO_GODIN-Swift.h"

@class SGBlogEntry;

@interface SGBlogEntryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UILabel *blogTitleLabel;

@property (strong, nonatomic) SGBlogEntry *blogEntry;

@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textToTopViewConstraint;

- (void) updateBottomImageView;

@end
