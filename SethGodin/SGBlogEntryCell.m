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

@implementation SGBlogEntryCell

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
    self.contentView.backgroundColor = [UIColor tableCellBackgroundColor];
    self.bottomImageView.image = [UIImage bottomTableCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) setBlogEntry:(SGBlogEntry *) toEntry
{
    _blogEntry = toEntry;
    [self populateCell];
}

- (void) populateCell
{
    self.blogTitleLabel.text = _blogEntry.title;
}

@end
