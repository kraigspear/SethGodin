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
#import "SGFavoritesBlogItemsGetter.h"
#import "SGBlogItemsGetter.h"
#import "SGCurrentBlogItemsGetter.h"
#import "SGArchiveBlogItemsGetter.h"
#import "NSArray+Util.h"
#import "UIColor+General.h"
#import "SGSearchBlogItemsGetter.h"

#import <QuartzCore/QuartzCore.h>

@interface SGFeedItemsViewController ()

@end

@implementation SGFeedItemsViewController
{
@private
    NSArray *_blogItems;
    SGBlogItemsGetter *_contentGetter;
    NSUInteger _pageNumber;
    
    SGBlogEntry *_entry1;
    SGBlogEntry *_entry2;
    SGBlogEntry *_entry3;
    
    __weak SGBlogEntry *_blogEntry;
    
    SGFeedSelection *_feedSelection;
    
    SGMenuViewController *_menuViewController;
    
    CALayer          *_spinnerLayer;
    CALayer          *_loadingBackgroundLayer;
    
    NSInteger   buttonTopContant;
}

#pragma mark -
#pragma mark general

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _feedSelection = [SGFeedSelection selectionAsCurrent];
    
    self.searchTextField.borderStyle = UITextBorderStyleNone;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    
    buttonTopContant = self.buttonViewToLeftButtonViewConstraint.constant - 500;
    
    [self.view removeConstraint:self.buttonViewToLeftButtonViewConstraint];
    [self.view layoutSubviews];
    
    _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
    
	[self.upButton setImage:[UIImage upButton] forState:UIControlStateNormal];
    [self.downButton setImage:[UIImage downButton] forState:UIControlStateNormal];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"SETH GODIN"]];
    
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
    if(!self.searchTextField.hidden)
    {
        [self closeSearchView];
    }
    else
    {
        [self showMenu];
    }
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
    if(!_entry2) return;
    _blogEntry = _entry2;
    [self performSegueWithIdentifier:@"viewPostSeque" sender:nil];
}

- (IBAction)button3Action:(id)sender
{
    if(!_entry3) return;
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
            _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
            break;
        case kArchive:
            _contentGetter = [[SGArchiveBlogItemsGetter alloc] initWithMonth:_feedSelection.month andYear:_feedSelection.year];
            break;
        case kFavorites:
            _contentGetter = [[SGFavoritesBlogItemsGetter alloc] init];
            break;
        case kSearch:
            _contentGetter = [[SGSearchBlogItemsGetter alloc] initWithSearchText:_feedSelection.searchText];
            break;
        default:
            _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
            break;
    }
    
    [_contentGetter requestItemssuccess:^(NSArray *inItems)
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






- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"shareCount"])
    {
        [self updateButtonForEntry:object];
    }
}



#pragma mark -
#pragma mark update buttons

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

- (void) updateButtonImage:(SGBlogEntry*) inEntry forButton:(UIButton*) inButton withColor:(UIColor*) inColor
{
    
    SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    UIImage *buttonImage;
    
    if(inEntry)
    {
        buttonImage = [UIImage rssItemButtonForColor:inColor
                                             andSize:inButton.frame.size
                                               title:inEntry.title
                                              shared:inEntry.shareCount
                                             forDate:inEntry.datePublished
                                      formatDateWith:appDelegate.dateFormatterLongStyle];
    }
    
    
    [inButton setImage:buttonImage forState:UIControlStateNormal];
    
}


- (void) updateButtonForEntry:(SGBlogEntry*) inEntry
{
    if(!inEntry) return;
    
    if(inEntry == _entry1)
    {
        [self updateButtonImage:inEntry forButton:_rssItem1Button withColor:[UIColor firstButtonColor]];
    }
    else if(inEntry == _entry2)
    {
        [self updateButtonImage:inEntry forButton:_rssItem2Button withColor:[UIColor secondButtonColor]];
    }
    else if(inEntry == _entry3)
    {
        [self updateButtonImage:inEntry forButton:_rssItem3Button withColor:[UIColor thirdButtonColor]];
    }
    
}


- (void) updateButtons
{
    NSUInteger startAt = _pageNumber * 3;
    
    [self updateButtonsToEmtpy];
    
    
    [_entry1 removeObserver:self forKeyPath:@"shareCount"];
    [_entry2 removeObserver:self forKeyPath:@"shareCount"];
    [_entry3 removeObserver:self forKeyPath:@"shareCount"];
    
    _entry1 = nil;
    _entry2 = nil;
    _entry3 = nil;
    
    if(_blogItems.count == 0)
    {
        return;
    }
    
    _entry1 = [_blogItems safeObjectAtIndex:startAt];
    _entry2 = [_blogItems safeObjectAtIndex:startAt+1];
    _entry3 = [_blogItems safeObjectAtIndex:startAt+2];
    
    [_entry1 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    [_entry2 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    [_entry3 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    
    if(_entry1) [self updateButtonForEntry:_entry1];
    if(_entry2) [self updateButtonForEntry:_entry2];
    if(_entry3) [self updateButtonForEntry:_entry3];
    
}

- (void) updateButtonsToEmtpy
{
    UIImage *img1 = [UIImage rssItemButtonForColor:[UIColor firstButtonColor] andSize:self.rssItem2Button.frame.size];
    UIImage *img2 = [UIImage rssItemButtonForColor:[UIColor secondButtonColor] andSize:self.rssItem2Button.frame.size];
    UIImage *img3 = [UIImage rssItemButtonForColor:[UIColor thirdButtonColor] andSize:self.rssItem3Button.frame.size];
    [self.rssItem1Button setImage:img1 forState:UIControlStateNormal];
    [self.rssItem2Button setImage:img2 forState:UIControlStateNormal];
    [self.rssItem3Button setImage:img3 forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark navigation buttons

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
    
    SGBlogEntry *startEntry = [_blogItems safeObjectAtIndex:startAt];
    
    if(startEntry != nil)
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

#pragma mark -
#pragma mark searching

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchBlogFor:textField.text];
    return [textField resignFirstResponder];
}

- (void) searchBlogFor:(NSString*) inText
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsSearch:inText];
    [[SGNotifications sharedInstance] postFeedSelection:feedSelection];
    [self closeSearchView];
}

- (void) closeSearchView
{
   [self.searchTextField resignFirstResponder];
   self.searchTextField.hidden = YES;
   self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"SETH GODIN"]];
   [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
   [self fadeToolbarAnimation];
}

- (IBAction)searchAction:(id)sender
{
    if(!self.searchTextField.hidden) return;
    
    self.searchTextField.hidden = NO;
    
    [self.menuButton setImage:[UIImage closeButton] forState:UIControlStateNormal];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@""]];
    [self.searchTextField becomeFirstResponder];
    [self fadeToolbarAnimation];
}

- (void) fadeToolbarAnimation
{
    CATransition *animation = [CATransition animation];
	animation.delegate = self;
	animation.duration = .25f;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	animation.type = kCATransitionFade;
    
	[self.topView exchangeSubviewAtIndex:0 withSubviewAtIndex:0];
	[self.topView.layer addAnimation:animation forKey:@"animation"];
}


@end
