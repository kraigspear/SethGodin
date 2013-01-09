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
#import "SGFavoritesCoreData.h"
#import "SGNotifications.h"


@implementation SGBlogEntryViewController
{
@private
    id _blogEntrySelected;
    id _menuSelected;
    __weak UIViewController *_menuController;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_IPAD)
    {
        _blogEntrySelected = [SGNotifications observeBlogEntrySelectedNotification:^(NSNotification *notification)
        {
            self.blogEntry = notification.object;
            [self viewDidLayoutSubviews];
        }];
    }
    
    self.blogTitleLabel.textColor   = [UIColor titlebarTextColor];
    self.titleView.backgroundColor = [UIColor blogEntryTitleBackgroundColor];
    
    if(IS_IPHONE)
    {
        self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"SETH GODIN"]];
        [self.backButton setImage:[UIImage backButton] forState:UIControlStateNormal];
    }
    else
    {
        self.topView.backgroundColor = [UIColor blackColor];
        _menuSelected = [SGNotifications observeMenuSelectedNotification:^(NSNotification *notification)
        {
            [self showMenu];
        }];
    }
    
    
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
    
    [self.shareButton setImage:[UIImage shareButton] forState:UIControlStateNormal];
    
    [self.favoritesButton setImage:[UIImage favoritesButton:NO] forState:UIControlStateNormal];
    [self.favoritesButton setImage:[UIImage favoritesButton:YES] forState:UIControlStateSelected];
    
    [self updateButtonSelected];
    
}

- (void) updateButtonSelected
{
//    [SGFavoritesCoreData isBlogItemFavorite:self.blogEntry success:^(BOOL isFavorite)
//    {
//        self.favoritesButton.selected = isFavorite;
//    }];
}

- (void) viewDidLayoutSubviews
{
    if(IS_IPHONE)
    {
        //self.titleView.backgroundColor = [UIColor colorWithPatternImage:[self titleImageiPhone]];
    }
    else
    {
        //self.titleView.backgroundColor = [UIColor colorWithPatternImage:[self titleImageiPad]];
    }
    
    self.blogTitleLabel.text = self.blogEntry.title;

    CGSize size = CGSizeMake(self.blogTitleLabel.frame.size.width, 1000);
    size = [self.blogTitleLabel sizeThatFits:size];
    
    size.height += 25;
    
    self.titleLabelHeightConstraint.constant = size.height;
    self.titleViewHeightConstraint.constant  = size.height + 25;
    
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

- (UIImage*) titleImageiPad
{
    return [UIImage imageForSize:self.titleView.frame.size withDrawingBlock:^
            {
                //// Color Declarations
                
                SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
                //// Abstracted Attributes
                NSString* titleTextContent = self.blogEntry.title;
                NSString* dateTextContent =  [appDelegate.dateFormatterLongStyle stringFromDate:self.blogEntry.datePublished];
                
                
                //// backRect Drawing
                UIBezierPath* backRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 132)];
                [[UIColor blackColor] setFill];
                [backRectPath fill];
                
                
                //// titleText Drawing
                CGRect titleTextRect = CGRectMake(16, 10, self.view.frame.size.width, 84);
                [[UIColor whiteColor] setFill];
                
                CGRect smallerRect = CGRectInset(titleTextRect, 0, 5);
                UIFont *drawWithFont = [titleTextContent fontThatWillFitUsingFont:[UIFont fontWithName: @"HelveticaNeue-Bold" size: 21.5] insideRect:smallerRect];
                
                
                [titleTextContent drawInRect: titleTextRect withFont: drawWithFont lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentLeft ];
                
                
                //// dateText Drawing
                CGRect dateTextRect = CGRectMake(17, 100, 222, 35);
                [[UIColor whiteColor] setFill];
                [dateTextContent drawInRect: dateTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentLeft ];
            }];

}

- (UIImage*) titleImageiPhone
{
 
    return [UIImage imageForSize:self.titleView.frame.size withDrawingBlock:^
    {
        //// Color Declarations
        
        SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
        //// Abstracted Attributes
        NSString* titleTextContent = self.blogEntry.title;
        NSString* dateTextContent =  [appDelegate.dateFormatterLongStyle stringFromDate:self.blogEntry.datePublished];
        
        
        //// backRect Drawing
        UIBezierPath* backRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 132)];
        [[UIColor tableCellBackgroundColor] setFill];
        [backRectPath fill];
        
        
        //// titleText Drawing
        CGRect titleTextRect = CGRectMake(16, 10, 282, 84);
        [[UIColor whiteColor] setFill];
        
        CGRect smallerRect = CGRectInset(titleTextRect, 0, 5);
        UIFont *drawWithFont = [titleTextContent fontThatWillFitUsingFont:[UIFont fontWithName: @"HelveticaNeue-Bold" size: 21.5] insideRect:smallerRect];
        
        
        [titleTextContent drawInRect: titleTextRect withFont: drawWithFont lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentLeft ];
        
        
        //// dateText Drawing
        CGRect dateTextRect = CGRectMake(17, 100, 222, 35);
        [[UIColor whiteColor] setFill];
        [dateTextContent drawInRect: dateTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentLeft ];
    }];
}

#pragma mark -
#pragma mark action handlers
- (IBAction)favoritesAction:(id)sender
{
    self.favoritesButton.selected = !self.favoritesButton.selected;
    [SGFavoritesCoreData toggleBlogEntryAsAFavorite:self.blogEntry];
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

#pragma mark -
#pragma mark menu

- (void) hideMenu
{
    [_menuController.view removeFromSuperview];
    [_menuController removeFromParentViewController];
    _menuController = nil;
}

//Show the menu. Only should be called if running on an iPad
- (void) showMenu
{
    if(_menuController)
    {
        [self hideMenu];
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"menu"];
    _menuController = vc;
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [vc.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *topConstraint =
	[NSLayoutConstraint
     constraintWithItem:vc.view
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.topView
     attribute:NSLayoutAttributeBottom
     multiplier:1.0f
     constant:0.0f];
    
    NSLayoutConstraint *heightConstraint =
    [NSLayoutConstraint constraintWithItem:vc.view
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0f
                                  constant:200.0f];
    
    NSLayoutConstraint *leadingConstraint =
    [NSLayoutConstraint constraintWithItem:vc.view
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeading
                                multiplier:1.0f
                                  constant:0.0f];
    
    NSLayoutConstraint *trailingConstraint =
    [NSLayoutConstraint constraintWithItem:vc.view
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1.0f
                                  constant:0.0f];
    
    [self.view addConstraints:@[topConstraint, heightConstraint, leadingConstraint, trailingConstraint]];
    
    [self.view layoutIfNeeded];
}

@end
