//
//  SGPostView.m
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogEntryViewController.h"
#import "UIImage+RSSSelection.h"
#import "UIColor+General.h"
#import "UIImage+General.h"
#import "UIImage+BBlock.h"
#import "SGBlogEntry.h"
#import "SGAppDelegate.h"
#import "SGFavorites.h"
#import "SGWebViewController.h"
#import "NSString+Util.h"
#import "AFNetworking.h"
#import "BlockTypes.h"
#import "SGFavoritesParse.h"
#import "SGNotifications.h"


@implementation SGBlogEntryViewController
{
@private
    id _blogEntrySelected;
    __weak UIViewController *_menuController;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.blogTitleLabel.textColor   = [UIColor titlebarTextColor];
    self.dateLabel.textColor = [UIColor titlebarTextColor];
    self.titleView.backgroundColor = [UIColor blogEntryTitleBackgroundColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.984 blue:0.937 alpha:1];
    
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
    
}

- (void) updateTitleForBlogEntry
{
    if(self.blogTitleLabel.frame.size.height == 0) return;
    
    CGSize size = CGSizeMake(self.blogTitleLabel.frame.size.width, 1000);
    
    
    UIFont *fontBlogItemTitle = [self fontForBlogItemTitle];
    self.blogTitleLabel.font = fontBlogItemTitle;
    
    NSString *titleText = self.blogEntry.title;
    self.blogTitleLabel.text = titleText;
 
    CGSize labelSize = [titleText sizeWithFont:fontBlogItemTitle constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@"labelHeight = %f", labelSize.height);
    
    CGFloat height = labelSize.height + 60;
    
    self.titleViewHeightConstraint.constant = height;
    
    [self updateButtonSelected];
    
}


- (UIFont*) fontForBlogItemTitle
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:24];
}

- (void) setBlogEntry:(SGBlogEntry *) toEntry
{
    _blogEntry = toEntry;
    [self.view layoutIfNeeded];
}

- (void) updateButtonSelected
{
   [SGFavoritesParse isBlogItemFavorite:self.blogEntry success:^(BOOL isFavorite)
    {
       self.favoritesButton.selected = isFavorite;
    }];
}

- (void) viewDidLayoutSubviews
{
    [self updateTitleForBlogEntry];
    
    self.scrollView.contentOffset = CGPointZero;
    self.titleView.backgroundColor = [self titleViewBackgroundColor];
    
    NSString *htmlWithStyle = [NSString stringWithFormat:@" <html> \n"
                                   "<head> <meta charset='utf-8'> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@; margin: 20px; background-color: #FFF9E7; }\n"
                                   "img, object {max-width:100%%; }\n"
                                   "a {text-decoration: none; color: #FF9900; font-weight: bold;}  \n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>%@</body> \n"
                               "</html>", @"HelveticaNeue", [NSNumber numberWithInt:18], self.blogEntry.content];
    
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

- (IBAction)shareAction:(id)sender
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

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
        SGWebViewController *vc = (SGWebViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
        
        [vc navigateToURL:request.URL];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    return NO;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGRect frame = webView.frame;
    frame.size.height = 1;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    
    NSLog(@"height = %f", frame.size.height);
    
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
         [Flurry logError:@"TinyURLError" message:@"Error getting url from TinyURL" error:error];
         NSLog(@"Error getting tiny url %@", error);
         inBlock(self.blogEntry.urlStr);
     }];
    
    [operation start];
    
}

- (UIColor*) titleViewBackgroundColor
{
    return [UIColor tableCellBackgroundColor];
}

@end
