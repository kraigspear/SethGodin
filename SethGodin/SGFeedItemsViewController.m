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
#import "SGLoadingAnimation.h"
#import "BlockAlertView.h"

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
    
    SGLoadingAnimation *_loadingAnimation;
    
    BlockAlertView *_blockAlertView;
    
    NSUInteger _pageNumberHold;
    NSArray    *_itemsHold;
    NSString   *_title;
    
}

#pragma mark -
#pragma mark general

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _title = @"SETH GODIN";
    
    _loadingAnimation = [[SGLoadingAnimation alloc] initWithView:self.view topConstraint:self.buttonViewToTopViewConstraint];
    
    _feedSelection = [SGFeedSelection selectionAsCurrent];
    
    self.searchTextField.borderStyle = UITextBorderStyleNone;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    
    buttonTopContant = self.buttonViewToLeftButtonViewConstraint.constant - 500;
    
    [self.view removeConstraint:self.buttonViewToLeftButtonViewConstraint];
    [self.view layoutSubviews];
    
    _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
    
	[self.upButton setImage:[UIImage upButton] forState:UIControlStateNormal];
    [self.downButton setImage:[UIImage downButton] forState:UIControlStateNormal];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:_title]];
    
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
        postVC.postHeaderColor = [UIColor firstButtonColor];
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
    if(_menuViewController) return;
    if(self.navigationController.visibleViewController != self) return;
    [self loadLatestFeedData];
}

- (void) loadLatestFeedData
{
    
    [self startLoadingAnimation];
    
    switch (_feedSelection.feedType)
    {
        case kCurrent:
            _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
            _title = @"SETH GODIN";
            self.topView.backgroundColor =[UIColor colorWithPatternImage:[UIImage defaultTitleBarImage]];
            break;
        case kArchive:
            _contentGetter = [[SGArchiveBlogItemsGetter alloc] initWithMonth:_feedSelection.month andYear:_feedSelection.year];
            
            _title = [self monthYearString];
            self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:_title]];
            
            break;
        case kFavorites:
            _contentGetter = [[SGFavoritesBlogItemsGetter alloc] init];
            _title = @"FAVORITES";
             self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:_title]];
            break;
        case kSearch:
            _contentGetter = [[SGSearchBlogItemsGetter alloc] initWithSearchText:_feedSelection.searchText];
            break;
        default:
             _title = @"SETH GODIN";
            _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
            self.topView.backgroundColor =[UIColor colorWithPatternImage:[UIImage defaultTitleBarImage]];
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
         [self stopLoadingAnimation];
         [self showError:inError];
     }];
}

- (NSString*) monthYearString
{
    SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    NSString *monthStr = [appDelegate.dateFormatterLongStyle.monthSymbols objectAtIndex:_feedSelection.month - 1];
    
    return [NSString stringWithFormat:@"%@, %d", monthStr, _feedSelection.year];
}

- (void) showError:(NSError*) inError
{
    _blockAlertView = [BlockAlertView alertWithTitle:@"Error" message:inError.localizedDescription];
    
    __weak SGFeedItemsViewController *weakSelf = self;
    
    [_blockAlertView setCancelButtonWithTitle:@"Ok" block:^
     {
         SGFeedItemsViewController *strongSelf = weakSelf;
         if(strongSelf)
         {
             strongSelf->_blockAlertView = nil;
         }
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
    
    self.rssItem1Button.hidden = !_entry1;
    self.rssItem2Button.hidden = !_entry2;
    self.rssItem3Button.hidden = !_entry3;
    
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
    [_loadingAnimation startLoadingAnimation];
}

- (void) stopLoadingAnimation
{
    [_loadingAnimation stopLoadingAnimation];
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
    if(!_itemsHold)
    {
        _itemsHold = _blogItems;
        _pageNumberHold = _pageNumber;
    }
    
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsSearch:inText];
    [[SGNotifications sharedInstance] postFeedSelection:feedSelection];
    [self.searchTextField resignFirstResponder];
}

- (void) closeSearchView
{
   [self.searchTextField resignFirstResponder];
   self.searchTextField.hidden = YES;
    
   self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:_title]];
    
   [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
   [self fadeToolbarAnimation];
    
    if(_itemsHold)
    {
        _blogItems = _itemsHold;
        _pageNumber = _pageNumberHold;
    }
    
    _itemsHold = nil;
    
    [self updateButtons];
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
