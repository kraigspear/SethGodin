//
//  SGPostView.m
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogEntryViewController.h"
#import "UIColor+General.h"
#import "UIImage+General.h"
#import "SGBlogEntry.h"
#import "SGAppDelegate.h"
#import "AFNetworking.h"
#import "BlockTypes.h"
#import "SGFavoritesParse.h"
#import "SVWebViewController.h"


@implementation SGBlogEntryViewController
{
@private
    CGPoint _scrollPointBeforeShowingWebView;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.blogTitleLabel.textColor   = [UIColor titlebarTextColor];
    self.dateLabel.textColor = [UIColor titlebarTextColor];
    
    self.titleView.backgroundColor = [UIColor tableCellBackgroundColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.984 blue:0.937 alpha:1];
    
    [[SGFavoritesParse alloc] init];
    
    for (UIView* subView in self.webView.subviews)
    {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView* shadowView in [subView subviews])
            {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    [shadowView setHidden:YES];
                }
            }
        }
    }
    
    self.webView.scrollView.scrollEnabled = NO;
    
    [self.shareButton setImage:[UIImage shareButton] forState:UIControlStateNormal];
    
    [self.favoritesButton setImage:[UIImage favoritesButton:NO] forState:UIControlStateNormal];
    [self.favoritesButton setImage:[UIImage favoritesButton:YES] forState:UIControlStateSelected];
    
    [self updateButtonSelected];


}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!CGPointEqualToPoint(CGPointZero, _scrollPointBeforeShowingWebView))
    {
        self.scrollView.contentOffset = _scrollPointBeforeShowingWebView;
    }
}

- (void) updateTitleForBlogEntry
{
    NSString *titleText = self.blogEntry.title;
    self.blogTitleLabel.text = titleText;
    self.dateLabel.text = [[[SGAppDelegate instance] dateFormatterLongStyle] stringFromDate:self.blogEntry.datePublished];
}

- (void) setBlogEntry:(SGBlogEntry *) toEntry
{
    _blogEntry = toEntry;
    [self updateButtonSelected];
}

- (void) updateButtonSelected
{
    __weak SGBlogEntryViewController *weakSelf = self;
    
    if(!self.blogEntry)
    {
        return;
    }
    
    [SGFavoritesParse isBlogItemFavorite:self.blogEntry success:^(BOOL exist)
    {
        SGBlogEntryViewController *strongSelf = weakSelf;
        
        if(strongSelf)
        {
            strongSelf.favoritesButton.selected = exist;
        }
    }];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self updateTitleForBlogEntry];
}

- (void) viewDidLayoutSubviews
{
    [self loadHTMLForBlogEntry];
}

- (void) loadHTMLForBlogEntry
{

    //This is needed on the iPhone to make sure that the resizing logic works.
    //On the iPad it has the oppisite effect. Don't know why....
    if(IS_IPHONE)
    {
        [self.view layoutIfNeeded];
    }
    
    [self updateTitleForBlogEntry];
    
    self.scrollView.contentOffset = CGPointZero;
    
    if(!self.blogEntry) return;
    if(!self.blogEntry.content) return;
    
        NSString *htmlWithStyle = [NSString stringWithFormat:@" <html> \n"
                                                                     "<head> <meta charset='utf-8'> \n"
                                                                     "<style type=\"text/css\"> \n"
                                                                     "body {font-family: \"%@\"; font-size: %@; margin: 20px; background-color: #FFF9E7; }\n"
                                                                     "img, object {max-width:100%%; }\n"
                                                                     "a {text-decoration: none; color: #FF9900; font-weight: bold;}  \n"
                                                                     "</style> \n"
                                                                     "</head> \n"
                                                                     "<body>%@</body> \n"
                                                                     "</html>", @"HelveticaNeue", @18, self.blogEntry.content];
        
        [self.webView loadHTMLString:htmlWithStyle baseURL:nil];
    
    
    [self.view layoutIfNeeded];
}



#pragma mark -
#pragma mark action handlers
- (IBAction)favoritesAction:(id)sender
{
    self.favoritesButton.selected = !self.favoritesButton.selected;
    [SGFavoritesParse toggleBlogEntryAsAFavorite:self.blogEntry];
}

#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    if(![[[request.URL description] substringToIndex:4] isEqualToString:@"http"])
    {
        return YES;
    }
    
    NSString *urlStr = [request.URL absoluteString];
    
    if([urlStr rangeOfString:@"itunes.apple.com"].length > 0)
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }

    SGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if(appDelegate.isNetworkAvailable)
    {
        NSLog(@"scrollview contentoffset = %@", NSStringFromCGPoint(self.scrollView.contentOffset));
        SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:request.URL];
        webViewController.barsTintColor = [UIColor blackColor];
        _scrollPointBeforeShowingWebView = self.scrollView.contentOffset;
        [self presentViewController:webViewController animated:YES completion:^
         {
             NSLog(@"webview presented scrollview contentoffset = %@", NSStringFromCGPoint(self.scrollView.contentOffset));
             self.scrollView.contentOffset = CGPointMake(0, 0);
         }];
    }
    
    return NO;
}



- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    self.webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    
    self.webView.frame = frame;
    self.scrollView.contentSize = CGSizeMake(webView.frame.size.width, fittingSize.height + self.titleView.frame.size.height);
    
    self.webViewHeightConstraint.constant = fittingSize.height;
    
    [self.view layoutIfNeeded];
}

#pragma mark -

- (void) urlStringForPost:(SWStringBlock) inBlock
{
    
    if([self.blogEntry.urlStr rangeOfString:@"sethgodin.typepad.com"].length == 0)
    {
        inBlock(self.blogEntry.urlStr);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@", self.blogEntry.urlStr]];
    
    NSURLRequest *request = [ NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                          timeoutInterval:5 ];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         inBlock(responseStr);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error getting tiny url %@", error);
         inBlock(self.blogEntry.urlStr);
     }];
    
    [operation start];
    
}

- (void) shareBlogEntry
{
    [self urlStringForPost:^(NSString *urlStr)
     {
         NSURL *url = [NSURL URLWithString:urlStr];
         
         NSString *shareText = [NSString stringWithFormat:@"%@ - Seth Godin's Blog", self.blogEntry.title];
         NSArray  *shareItems = @[shareText, url];
         
         UIActivityViewController *activityViewController =
         [[UIActivityViewController alloc]
          initWithActivityItems:shareItems
          applicationActivities:nil];
         
         
         [self presentViewController:activityViewController animated:YES completion:nil];
     }];
}

#pragma mark -
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"SETH GODIN";
}

- (UIImage*) rightButtonImage
{
    return [UIImage shareButton];
}

- (UIImage*) leftButtonImage
{
    return [UIImage backButtonWithColor:[UIColor whiteColor]];
}

- (void) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) rightButtonAction:(id)sender
{
    [self shareBlogEntry];
}

- (UIColor*) titleTextColor
{
    return [UIColor whiteColor];
}

- (UIColor*) titleViewBackgroundColor
{
    return [UIColor titlebarBackgroundColor];
}

@end
