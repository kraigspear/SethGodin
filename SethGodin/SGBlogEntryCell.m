//
//  SGBlogEntryCell.m
//  SethGodin
//
//  Created by Kraig Spear on 1/6/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGBlogEntryCell.h"
#import "SGBlogEntry.h"
#import "UIImage+RSSSelection.h"
#import "UIColor+General.h"
#import "SGAppDelegate.h"
#import "SGNotifications.h"

@implementation SGBlogEntryCell
{
@private
    id _shareCountUpdatedObserver;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    _shareCountUpdatedObserver = [SGNotifications observeShareCountUpdated:^(NSNotification *notification)
    {
        SGBlogEntry *blogEntry = notification.object;
        if(blogEntry == self.blogEntry)
        {
            [self updateShareCountLabel];
        }
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor tableCellBackgroundColor];
    self.bottomImageView.image = [UIImage bottomTableCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIColor *textColor = selected ? [UIColor textColorSelected] : [UIColor titlebarTextColor];
    self.blogTitleLabel.textColor = textColor;
}

- (void) setBlogEntry:(SGBlogEntry *) toEntry
{
    _blogEntry = toEntry;
    [self populateCell];
}

- (void) populateCell
{
    self.blogTitleLabel.text = _blogEntry.title;
    
    self.postDateLabel.text = [[[SGAppDelegate instance] dateFormatterLongStyle] stringFromDate:_blogEntry.datePublished];
    
    [self updateShareCountLabel];
}

- (void) updateShareCountLabel
{
    self.shareCountLabel.text = [NSString stringWithFormat:@"%d", _blogEntry.shareCount];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_shareCountUpdatedObserver];
    _shareCountUpdatedObserver = nil;
}

@end
