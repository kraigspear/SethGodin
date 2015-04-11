//
//  SGWebViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGWebViewController : UIViewController <UIWebViewDelegate>

/**
 Navigate the browser to a URL
 @param inURL Url to naviagate to.
 */
- (void) navigateToURL:(NSURL*) inURL;

/**
 Browser control to display the web content.
 */
@property (weak, nonatomic) IBOutlet UIWebView *webView;

/**
 Browser previous button
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;

/**
 Browser next button
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

/**
 Activity indiacator, to show/animate when a page is loading.
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndiacator;

@end
