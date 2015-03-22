//
//  SGPostView.h
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGTitleView.h"


@class SGBlogEntry;

/**
 ViewController for the blog post view
 */
@interface SGBlogEntryViewController : GAITrackedViewController <UIWebViewDelegate, SGTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

/**
 
 */
@property (weak, nonatomic) IBOutlet UIView *titleView;

/**
 The blog entry that we are showing information for.
 */
@property (nonatomic, strong) SGBlogEntry *blogEntry;

/**
 Button that toggles this blog post as being a favorite or not.
 */
@property (weak, nonatomic) IBOutlet UIButton *favoritesButton;

/**
 Shows the actual content of the blog
 */
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/**
 Button to trigger sharing this blog post
 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *blogTitleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLableToTopViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


- (void) shareBlogEntry;

#pragma mark -
#pragma mark device specific messages

/**
 Update the title of the blog entry.
 */
- (void) updateTitleForBlogEntry;


/**
 Color to use for the blog header background
 */
- (UIColor*) titleViewBackgroundColor;


@end
