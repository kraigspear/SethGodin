//
//  SGBlogEntryViewController_ipad.m
//  SethGodin
//
//  Created by Kraig Spear on 1/16/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGBlogEntryViewController_ipad.h"

#import "SGNotifications.h"
#import "SGAppDelegate.h"

@interface SGBlogEntryViewController_ipad ()

@end

@implementation SGBlogEntryViewController_ipad
{
@private
    id _blogEntrySelected;
}

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
	
    _blogEntrySelected = [SGNotifications observeBlogEntrySelectedNotification:^(NSNotification *notification)
                          {
                              self.blogEntry = notification.object;
                              [self viewDidLayoutSubviews];
                          }];
    
    self.topView.backgroundColor = [UIColor blackColor];
    self.titleView.backgroundColor = [UIColor blackColor];
}

- (UIFont*) fontForBlogItemTitle
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:35];
}

- (UIColor*) titleViewBackgroundColor
{
    return [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) addToHeight
{
    return 50;
}


@end
