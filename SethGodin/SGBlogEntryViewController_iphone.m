//
//  SGBlogEntryViewController_iphone.m
//  SethGodin
//
//  Created by Kraig Spear on 1/16/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGBlogEntryViewController_iphone.h"

#import "UIImage+General.h"
#import "UIColor+General.h"
#import "UIFont+General.h"

@interface SGBlogEntryViewController_iphone ()

@end

@implementation SGBlogEntryViewController_iphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleLabel.textColor    = [UIColor blogEntriesTextColor];
    self.titleLabel.font         = [UIFont blogEntriesTitleFont];
    
    [self updateTitleForBlogEntry];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
