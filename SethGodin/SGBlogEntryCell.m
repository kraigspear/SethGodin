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
    SGBlogEntry *_blogEntry;
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
        
        if(blogEntry == _blogEntry)
        {
            [self updateShareCountLabel];
        }
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor tableCellBackgroundColor];
    [self updateBottomImageView];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self updateBottomImageView];
}

- (void) updateBottomImageView
{
    self.bottomImageView.image = [UIImage bottomTableCellForSize:CGSizeMake(self.frame.size.width, 50)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIColor *textColor = selected ? [UIColor textColorSelected] : [UIColor titlebarTextColor];
    self.blogTitleLabel.textColor = textColor;
}

- (void) setBlogEntry:(SGBlogEntry *)blogEntry
{
    _blogEntry = blogEntry;
    [self populateCell];
}

- (void) populateCell
{
    self.blogTitleLabel.text = _blogEntry.title;
    
    NSDate *datePublished = _blogEntry.datePublished;
    
    if(datePublished)
    {
        self.postDateLabel.text = [[[SGAppDelegate instance] dateFormatterLongStyle] stringFromDate:datePublished];
    }
    else
    {
        self.postDateLabel.text = @"";
    }
    
    [self updateShareCountLabel];
}

- (void) updateShareCountLabel
{
    self.shareCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long) _blogEntry.shareCount];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_shareCountUpdatedObserver];
    _shareCountUpdatedObserver = nil;
}

@end
