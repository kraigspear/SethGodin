//
//  SGWebViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGWebViewController.h"
#import "UIImage+General.h"

@interface SGWebViewController ()

@end

@implementation SGWebViewController
{
@private
    NSURL *_urlToLoad;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.previousButton setImage:[UIImage previousButton]];
    [self.nextButton     setImage:[UIImage nextButton]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_urlToLoad];
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) navigateToURL:(NSURL*) inURL
{
    _urlToLoad = inURL;
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndiacator startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndiacator stopAnimating];
}

@end
