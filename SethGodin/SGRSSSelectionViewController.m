//
//  SGViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGRSSSelectionViewController.h"
#import "UIImage+RSSSelection.h"
#import "SGBlogContentGetter.h"
#import "SGBlogEntry.h"
#import "SGPostViewController.h"
#import "SGAppDelegate.h"

@interface SGRSSSelectionViewController ()

@end

@implementation SGRSSSelectionViewController
{
@private
    NSArray *_blogItems;
    SGBlogContentGetter *_contentGetter;
    NSUInteger _pageNumber;
    
    SGBlogEntry *_entry1;
    SGBlogEntry *_entry2;
    SGBlogEntry *_entry3;
    
    __weak SGBlogEntry *_blogEntry;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _contentGetter = [[SGBlogContentGetter alloc] init];
    
	[self.upButton setImage:[UIImage upButton] forState:UIControlStateNormal];
    [self.downButton setImage:[UIImage downButton] forState:UIControlStateNormal];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBar]];
    
    [self.searchButton setImage:[UIImage searchButton] forState:UIControlStateNormal];
    [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
    
    _pageNumber = 0;
    
    [self loadLatestFeedData];
    
    if(&UIApplicationWillEnterForegroundNotification != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredForegrond) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    
}

- (void) appEnteredForegrond
{
    [self loadLatestFeedData];
}

- (void) viewDidLayoutSubviews
{
    
}

- (void) loadLatestFeedData
{
    [_contentGetter requestLatestBlocksuccess:^(NSArray *inItems)
     {
         _pageNumber = 0;
         _blogItems = inItems;
         [self updateButtons];
     } failed:^(NSError *inError)
     {
         
     }];
}

- (void) updateButtons
{
    NSUInteger startAt = _pageNumber * 3;
    
    [_entry1 removeObserver:self forKeyPath:@"shareCount"];
    [_entry2 removeObserver:self forKeyPath:@"shareCount"];
    [_entry3 removeObserver:self forKeyPath:@"shareCount"];
    
    _entry1 = [_blogItems objectAtIndex:startAt];
    _entry2 = [_blogItems objectAtIndex:startAt+1];
    _entry3 = [_blogItems objectAtIndex:startAt+2];
    
    [_entry1 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    [_entry2 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    [_entry3 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    
    [self updateButtonForEntry:_entry1];
    [self updateButtonForEntry:_entry2];
    [self updateButtonForEntry:_entry3];
    
}

#pragma mark -
#pragma mark button actions

- (IBAction)button1Action:(id)sender
{
    _blogEntry = _entry1;
    [self performSegueWithIdentifier:@"viewPostSeque" sender:nil];
}

- (IBAction)button2Action:(id)sender
{
    _blogEntry = _entry2;
    [self performSegueWithIdentifier:@"viewPostSeque" sender:nil];
}

- (IBAction)button3Action:(id)sender
{
    _blogEntry = _entry3;
    [self performSegueWithIdentifier:@"viewPostSeque" sender:nil];
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"shareCount"])
    {
        [self updateButtonForEntry:object];
    }
}

- (void) updateButtonForEntry:(SGBlogEntry*) inEntry
{
    UIColor* buttonColor = [UIColor colorWithRed: 0.751 green: 0.703 blue: 0.608 alpha: 1];
    if(inEntry == _entry1)
    {
        [self updateButtonImage:inEntry forButton:_rssItem1Button withColor:buttonColor];
    }
    else if(inEntry == _entry2)
    {
        UIColor* buttonColor2 = [buttonColor colorWithAlphaComponent: 0.8];
        [self updateButtonImage:inEntry forButton:_rssItem2Button withColor:buttonColor2];
    }
    else if(inEntry == _entry3)
    {
        UIColor* buttonColor3 = [buttonColor colorWithAlphaComponent: 0.6];
        [self updateButtonImage:inEntry forButton:_rssItem3Button withColor:buttonColor3];
    }

}

- (void) updateButtonImage:(SGBlogEntry*) inEntry forButton:(UIButton*) inButton withColor:(UIColor*) inColor
{
    
    SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    
    UIImage *buttonImage = [UIImage rssItemButtonForColor:inColor
                                                   andSize:inButton.frame.size
                                                     title:inEntry.displayName
                                                    shared:inEntry.shareCount
                                                   forDate:inEntry.datePublished
                                            formatDateWith:appDelegate.dateformatter];
    
    [inButton setImage:buttonImage forState:UIControlStateNormal];
    
}


- (IBAction)previousButton:(id)sender
{
    NSInteger newPageNumber = _pageNumber - 1;
    
    if(newPageNumber >= 0)
    {
        _pageNumber = newPageNumber;
        [self updateButtons];
    }
    
}

- (IBAction)nextButton:(id)sender
{
    NSUInteger newPageNumber = _pageNumber + 1;
    NSUInteger startAt = newPageNumber * 3;
    
    NSUInteger lastItem = startAt + 3;
    
    if(lastItem <= (_blogItems.count - 1))
    {
        _pageNumber = newPageNumber;
        [self updateButtons];
    }
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"viewPostSeque"])
    {
        SGPostViewController *postVC = segue.destinationViewController;
        postVC.blogEntry = _blogEntry;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
