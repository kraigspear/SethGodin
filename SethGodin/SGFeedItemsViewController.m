//
//  SGViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFeedItemsViewController.h"
#import "UIImage+RSSSelection.h"

#import "SGBlogEntry.h"
#import "SGPostViewController.h"
#import "SGAppDelegate.h"
#import "UIImage+General.h"
#import "SGMenuViewController.h"
#import "SGNotifications.h"
#import "SGFeedSelection.h"

#import "SGConentGetter.h"
#import "SGCurrentContentGetter.h"
#import "SGArchiveContentGetter.h"

#import <QuartzCore/QuartzCore.h>

@interface SGFeedItemsViewController ()

@end

@implementation SGFeedItemsViewController
{
@private
    NSArray *_blogItems;
    SGConentGetter *_contentGetter;
    NSUInteger _pageNumber;
    
    SGBlogEntry *_entry1;
    SGBlogEntry *_entry2;
    SGBlogEntry *_entry3;
    
    __weak SGBlogEntry *_blogEntry;
    
    SGFeedSelection *_feedSelection;
    
    SGMenuViewController *_menuViewController;
    
    CALayer          *_spinnerLayer;
    CALayer          *_loadingBackgroundLayer;
    
    NSInteger buttonTopContant;
}

#pragma mark -
#pragma mark general

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _feedSelection = [SGFeedSelection selectionAsCurrent];
    
    buttonTopContant = self.buttonViewToLeftButtonViewConstraint.constant - 500;
    
    [self.view removeConstraint:self.buttonViewToLeftButtonViewConstraint];
    [self.view layoutSubviews];
    
    _contentGetter = [[SGCurrentContentGetter alloc] init];
    
	[self.upButton setImage:[UIImage upButton] forState:UIControlStateNormal];
    [self.downButton setImage:[UIImage downButton] forState:UIControlStateNormal];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"Seth Godin"]];
    
    [self.searchButton setImage:[UIImage searchButton] forState:UIControlStateNormal];
    [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
    
    _pageNumber = 0;
    
    [self loadLatestFeedData];
    
    if(&UIApplicationWillEnterForegroundNotification != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredForegrond) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    
    [[SGNotifications sharedInstance] observeFeedSelectionWithNotification:^(NSNotification *note)
    {
        _feedSelection = (SGFeedSelection*) note.object;
        [self loadLatestFeedData];
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _contentGetter = nil;
}


#pragma mark -
#pragma mark segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"viewPostSeque"])
    {
        SGPostViewController *postVC = segue.destinationViewController;
        postVC.blogEntry = _blogEntry;
    }
}




#pragma mark -
#pragma mark menu

- (IBAction)menuAction:(id)sender
{
    [self showMenu];
}

- (void) showMenu
{
    _menuViewController = (SGMenuViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    
    [self addChildViewController:_menuViewController];
    
    UIView *menuView = _menuViewController.view;
    
    CGRect menuFrame = menuView.frame;
    menuFrame.origin.y = -menuFrame.size.height;
    
    menuView.frame = menuFrame;
    
    [self.view addSubview:menuView];
    
    __weak SGFeedItemsViewController *weakSelf = self;
    
    _menuViewController.close = ^(BOOL shouldAnimate)
    {
        SGFeedItemsViewController *strongSelf = weakSelf;
        
        if(strongSelf)
        {
            [strongSelf closeMenuWithAnimation:shouldAnimate];
        }
        
    };
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
    {
        menuView.frame = CGRectMake(0, 0, menuFrame.size.width, menuFrame.size.height);
    }
    } completion:^(BOOL finished)
    {
        
    }];
    
}

- (void) closeMenuWithAnimation:(BOOL) inAnimate
{
    if(inAnimate)
    {
        [self animateCloseMenu];
    }
    else
    {
        [self removeMenuController];
    }
}

- (void) animateCloseMenu
{
    CGRect menuFrame = _menuViewController.view.frame;
    menuFrame.origin.y = -menuFrame.size.height;
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        {
            _menuViewController.view.frame = menuFrame;
        }
    } completion:^(BOOL finished)
     {
         if(finished)
         {
             [self removeMenuController];
         }
     }];

}

- (void) removeMenuController
{
    [_menuViewController.view removeFromSuperview];
    [_menuViewController removeFromParentViewController];
    _menuViewController = nil;
}

#pragma mark -
#pragma mark entry selection actions

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

#pragma mark -
#pragma mark feed loading

- (void) appEnteredForegrond
{
    [self loadLatestFeedData];
}


- (void) loadLatestFeedData
{
    
    [self startLoadingAnimation];
    
    switch (_feedSelection.feedType)
    {
        case kCurrent:
            _contentGetter = [[SGCurrentContentGetter alloc] init];
            break;
        case kArchive:
            _contentGetter = [[SGArchiveContentGetter alloc] initWithMonth:_feedSelection.month andYear:_feedSelection.year];
            break;
        default:
            _contentGetter = [[SGCurrentContentGetter alloc] init];
            break;
    }
    
    [_contentGetter requestLatestBlocksuccess:^(NSArray *inItems)
     {
         _pageNumber = 0;
         _blogItems = inItems;
         [self updateButtons];
         [self stopLoadingAnimation];
         [self animateButtonsComingDown];
     } failed:^(NSError *inError)
     {
         
     }];
}



- (void) animateButtonsComingDown
{
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationCurveEaseInOut animations:^
     {
         self.buttonViewToTopViewConstraint.constant += 500;
         [self.view addConstraint:self.buttonViewToLeftButtonViewConstraint];
         [self.view layoutSubviews];
     }
     completion:^(BOOL finished)
     {
         
     }];
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


#pragma mark -
#pragma mark navigation buttons

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

#pragma mark -
#pragma mark animation

- (void) startLoadingAnimation
{
    self.buttonViewToTopViewConstraint.constant = buttonTopContant;
    [self.view layoutSubviews];
    
    UIImage *loadingBackgroundImage = [UIImage imageNamed:@"load_bg.png"];
    UIImage *loadingTextImage       = [UIImage imageNamed:@"load_text.png"];
    
    CALayer *loadingTextLayer = [CALayer layer];
    loadingTextLayer.contents = (id) loadingTextImage.CGImage;
    
    CGFloat loadingTextX = (self.view.frame.size.width / 2) - (loadingTextImage.size.width / 2);
        
    loadingTextLayer.frame = CGRectMake(loadingTextX, 25, loadingTextImage.size.width, loadingTextImage.size.height);
    
    _loadingBackgroundLayer = [CALayer layer];
    _loadingBackgroundLayer.contents = (id) loadingBackgroundImage.CGImage;
    _loadingBackgroundLayer.frame = CGRectMake(0, 0, loadingBackgroundImage.size.width, loadingBackgroundImage.size.height);
    
    [_loadingBackgroundLayer addSublayer:loadingTextLayer];
    
    [self.view.layer addSublayer:_loadingBackgroundLayer];
    
    _spinnerLayer = [CALayer layer];
    
    UIImage *spinnerImage = [UIImage imageNamed:@"load_spinner.png"];
    
    _spinnerLayer.anchorPoint = CGPointMake(.5, .5);
    
    _spinnerLayer.contents = (id) spinnerImage.CGImage;
    
    _spinnerLayer.frame = CGRectMake(215, 180, spinnerImage.size.width, spinnerImage.size.height);
    
    [_loadingBackgroundLayer addSublayer:_spinnerLayer];
    
    CABasicAnimation *spinnerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    spinnerAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    spinnerAnimation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    spinnerAnimation.duration = 1;             // this might be too fast
    spinnerAnimation.repeatCount = HUGE_VALF;     // HUGE_VALF is defined in math.h so import it
    [_spinnerLayer addAnimation:spinnerAnimation forKey:@"rotation"];
    
}

- (void) stopLoadingAnimation
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseOut animations:^
     {
         _loadingBackgroundLayer.opacity = 0;
     }
    completion:^(BOOL finished)
    {
        if(finished)
        {
            [_spinnerLayer removeAllAnimations];
            [_spinnerLayer removeFromSuperlayer];
            _spinnerLayer = nil;
            
            [_loadingBackgroundLayer removeFromSuperlayer];
            _loadingBackgroundLayer = nil;
        }
    }];
}




@end
