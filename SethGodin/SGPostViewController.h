//
//  SGPostView.h
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGBlogEntry;

@interface SGPostViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (nonatomic, strong) SGBlogEntry *blogEntry;

@property (weak, nonatomic) IBOutlet UIButton *favoritesButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (nonatomic, strong) UIColor *postHeaderColor;


@end
