//
//  SGBlogEntryCell.h
//  SethGodin
//
//  Created by Kraig Spear on 1/6/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Seth_Godin-Swift.h"

@class SGBlogEntry;

@interface SGBlogEntryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UILabel *blogTitleLabel;

@property (strong, nonatomic) FeedItem *feedItem;

@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textToTopViewConstraint;

- (void) updateBottomImageView;

@end
