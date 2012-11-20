//
//  SGPostView.m
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGPostViewController.h"
#import "UIImage+RSSSelection.h"
#import "UIImage+General.h"
#import "UIImage+BBlock.h"
#import "SGBlogEntry.h"
#import "SGAppDelegate.h"
#import "SGFavorites.h"
#import "SGWebViewController.h"
#import "NSString+Util.h"
#import "AFNetworking.h"


@implementation SGPostViewController
{
@private
    SGFavorites *_favorites;
    BOOL _entryFavorite;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"SETH GODIN"]];
    [self.backButton setImage:[UIImage backButton] forState:UIControlStateNormal];
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
    
    _favorites = [SGFavorites loadFavorites];
    
    _entryFavorite = [_favorites containsBlogEntry:self.blogEntry];
    
    [self.favoritesButton setImage:[UIImage favoritesButton:NO] forState:UIControlStateNormal];
    [self.favoritesButton setImage:[UIImage favoritesButton:YES] forState:UIControlStateSelected];
    
    [self updateButtonSelected];
    
}

- (void) updateButtonSelected
{
    self.favoritesButton.selected = _entryFavorite;
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewDidLayoutSubviews
{
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[self titleImage]];
    
    NSString *htmlWithStyle = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@; margin: 20px;  }\n"
                                   "img, object {max-width:100%%; }\n"
                                   "a {text-decoration: none; color: #FFD500; font-weight: bold;}  \n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>%@</body> \n"
                                   "</html>", @"HelveticaNeue", [NSNumber numberWithInt:18], self.blogEntry.content];
    
    [self.webView loadHTMLString:htmlWithStyle baseURL:nil];
}

- (UIImage*) titleImage
{
    //NSString* titleTextContent = self.blogEntry.displayName;
    //NSString* dateTextContent =  [appDelegate.dateformatter stringFromDate:self.blogEntry.datePublished];

    return [UIImage imageForSize:self.titleView.frame.size withDrawingBlock:^
    {
        //// Color Declarations
        
        SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
        //// Abstracted Attributes
        NSString* titleTextContent = self.blogEntry.title;
        NSString* dateTextContent =  [appDelegate.dateFormatterLongStyle stringFromDate:self.blogEntry.datePublished];
        
        
        //// backRect Drawing
        UIBezierPath* backRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 132)];
        [self.postHeaderColor setFill];
        [backRectPath fill];
        
        
        //// titleText Drawing
        CGRect titleTextRect = CGRectMake(15, 17, 291, 84);
        [[UIColor whiteColor] setFill];
        
        UIFont *drawWithFont = [titleTextContent fontThatWillFitUsingFont:[UIFont fontWithName: @"HelveticaNeue-Bold" size: 26] insideRect:titleTextRect];
        
        [titleTextContent drawInRect: titleTextRect withFont: drawWithFont lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentLeft ];
        
        
        //// dateText Drawing
        CGRect dateTextRect = CGRectMake(17, 100, 222, 35);
        [[UIColor whiteColor] setFill];
        [dateTextContent drawInRect: dateTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentLeft ];
    }];
}

- (IBAction)favoritesAction:(id)sender
{
    if(_entryFavorite)
    {
        [_favorites removeBlogEntry:self.blogEntry];
    }
    else
    {
        [_favorites addBlogEntry:self.blogEntry];
    }

    _entryFavorite = [_favorites containsBlogEntry:self.blogEntry];
    [self updateButtonSelected];
    
}

- (IBAction)shareAction:(id)sender
{ 
    
    NSURL *url = [NSURL URLWithString:[self urlStringForPost]];
    
    NSArray *shareItems = @[self.blogEntry.title, @"Seth Godin's Blog", url];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc]
     initWithActivityItems:shareItems
     applicationActivities:nil];
    
    
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

- (NSString*) urlStringForPost
{
    return self.blogEntry.urlStr;
//    if([self.blogEntry.urlStr rangeOfString:@"sethgodin.typepad.com"].length == 0)
//    {
//        return self.blogEntry.urlStr;
//    }
    
  /* NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@", self.blogEntry.urlStr]];
    
   NSURLRequest *request = [ NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                          timeoutInterval:3 ];
    
   AFHTTPRequestOperation *operation = [
   */
    
    
}


#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    if(![[[request.URL description] substringToIndex:4] isEqualToString:@"http"])
    {
        return YES;
    }
    
    SGWebViewController *vc = (SGWebViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
    
    [vc navigateToURL:request.URL];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    return NO;
}


@end
