//
//  SGViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogEntriesViewController.h"
#import "UIImage+RSSSelection.h"

#import "SGBlogEntry.h"
#import "SGBlogEntryViewController.h"
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

#import "NSDate+General.h"
#import "SGUSerDefaults.h"
#import "SGFavorites.h"

#import "UIColor+General.h"
#import "UIFont+General.h"

#import "MBProgressHUD.h"

#import "SGBlogEntryCell.h"
#import "SGAlertView.h"
#import "Flurry.h"

#import <Parse/Parse.h>
#import "AFHTTPClient.h"
#import <QuartzCore/QuartzCore.h>

#define BLOG_ENTRY_CELL @"blogEntryCell"

@interface SGBlogEntriesViewController ()

@end

@implementation SGBlogEntriesViewController
{
@private
    NSArray *_blogItems;
    SGBlogItemsGetter *_contentGetter;
    
    __weak SGBlogEntry *_blogEntry;
    
    NSLayoutConstraint *_menuTopConstraint;
    NSLayoutConstraint *_menuBottomConstraint;
    
    SGFeedSelection *_feedSelection;
    
    SGMenuViewController *_menuViewController;
    
    CALayer          *_spinnerLayer;
    CALayer          *_loadingBackgroundLayer;
    
    NSInteger   buttonTopContant;
    
    SGLoadingAnimation *_loadingAnimation;
    
    NSUInteger _pageNumberHold;
    NSArray    *_itemsHold;
    NSString   *_title;
    
    AFHTTPClient *_httpClient;
    
    UIView *_messageView;
    
    SGAlertView *_alertView;
    
    NSDate *_lastDateLeftView;
    
    UIFont *_titleFont;
    
    __weak UIWindow *_keyWindow;
    
}

NSString * const SEGUE_TO_POST = @"viewPostSeque";

- (void) setIsNetworkingAvailable:(BOOL) toValue
{
    _isNetworkingAvailable = toValue;
    
    SGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.isNetworkAvailable = toValue;
    
    [SGNotifications postNetworkAvailable:toValue];
    
    self.searchButton.enabled = _isNetworkingAvailable;
}

#pragma mark -
#pragma mark general

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24];
    
    UINib *cellNib = [UINib nibWithNibName:@"BlogEntryCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:BLOG_ENTRY_CELL];
    
    _title = @"SETH GODIN";
    
    if(IS_IPHONE)
    {
        _loadingAnimation = [[SGLoadingAnimation alloc] initWithView:self.view topConstraint:self.buttonViewToTopViewConstraint];
    }
    
    _feedSelection = [SGFeedSelection selectionAsCurrent];
    
    self.searchTextField.borderStyle = UITextBorderStyleNone;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.textColor = [UIColor titlebarTextColor];
    
    _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
    
    //Top View
    self.topView.backgroundColor = [UIColor blogEntriesTopBarBackgroundColor];
    self.titleLabel.textColor    = [UIColor blogEntriesTextColor];
    self.titleLabel.font         = [UIFont blogEntriesTitleFont];
    
    [self.searchButton setImage:[UIImage searchButton] forState:UIControlStateNormal];
    [self.menuButton   setImage:[UIImage menuButton] forState:UIControlStateNormal];
    
    if(&UIApplicationWillEnterForegroundNotification != nil)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredForegrond) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [SGNotifications observeFeedSelectionWithNotification:^(NSNotification *note)
    {
        _feedSelection = (SGFeedSelection*) note.object;
        [self loadLatestFeedData];
    }];
    
    _httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://profile.typepad.com"]];
    
    __weak SGBlogEntriesViewController *weakSelf = self;
    
    [_httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        SGBlogEntriesViewController *strongSelf = weakSelf;
        if(strongSelf)
        {
            strongSelf.isNetworkingAvailable = (status == AFNetworkReachabilityStatusReachableViaWWAN) || (status == AFNetworkReachabilityStatusReachableViaWiFi);
            
            [strongSelf loadLatestFeedData];
        }
    }];
    
    if(![[SGUserDefaults sharedInstance] wasAskedToUseCloud])
    {
        
        if([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]])
        {
            [self askToUseCloud];
        }
        
        [[SGUserDefaults sharedInstance] setWasAskedToUseCloud:YES];
    }
}




- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == [SGAppDelegate instance])
    {
        if([keyPath isEqualToString:@"isICloudSetup"])
        {
            [[SGAppDelegate instance] removeObserver:self forKeyPath:@"isICloudSetup"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_lastDateLeftView)
    {
       if([_lastDateLeftView numberOfMinutesSince] > 30)
       {
           [self loadLatestFeedData];
       }
       else
       {
           _lastDateLeftView = nil;
       }
    }
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
    if(self.searchTextField.isFirstResponder)
    {
         [self closeSearchView];
    }
    
    if([segue.identifier isEqualToString:SEGUE_TO_POST])
    {
        _lastDateLeftView = [NSDate date];
        SGBlogEntryViewController *postVC = segue.destinationViewController;
        postVC.blogEntry = _blogEntry;
    }
}

#pragma mark -
#pragma mark menu

- (IBAction)menuAction:(id)sender
{
    if([self isInSearchState])
    {
        [self closeSearchView];
    }
    else
    {
        if(self.menuSelected)
        {
            self.menuSelected();
        }
        [self showMenu];
    }
}


- (void) showMenuiPhone
{
    _menuViewController = (SGMenuViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    _menuViewController.isNetworkAvailable = self.isNetworkingAvailable;
    
    [self addChildViewController:_menuViewController];
    
    UIView *menuView = _menuViewController.view;
    menuView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _menuTopConstraint = [NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:-self.view.frame.size.height];
    
    _menuBottomConstraint = [NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.view.frame.size.height];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    
    [self.view addSubview:menuView];
    
    [self.view addConstraints:@[_menuTopConstraint, _menuBottomConstraint, leadingConstraint, trailingConstraint]];
    
    __weak SGBlogEntriesViewController *weakSelf = self;
    
    _menuViewController.close = ^(BOOL shouldAnimate)
    {
        SGBlogEntriesViewController *strongSelf = weakSelf;
        
        if(strongSelf)
        {
            [strongSelf closeMenuWithAnimation:shouldAnimate];
        }
        
    };
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
    {
        _menuTopConstraint.constant = 0;
        _menuBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }
    } completion:^(BOOL finished)
    {
    }];

}

- (void) showMenuiPad
{
    [SGNotifications postMenuSelectedNotification:YES];
}

- (void) showMenu
{
    if(IS_IPHONE)
    {
        [self showMenuiPhone];
    }
    else
    {
        [self showMenuiPad];
    }
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
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationCurveEaseInOut animations:^
    {
        _menuTopConstraint.constant = -self.view.frame.size.height;
        _menuBottomConstraint.constant = -self.view.frame.size.height;
        [self.view layoutIfNeeded];
    }
    completion:^(BOOL finished)
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
#pragma mark feed loading

- (void) appEnteredForegrond
{
    [self stopLoadingAnimation];
    
    if(self.isViewLoaded && self.view.window)
    {
        //It's not worth refreshing a search, archive ext...
        //only the current feed might change between app sessions.
        if(_feedSelection.feedType == kCurrent)
        {
            [self loadLatestFeedData];
        }
    }
}

- (void) appEnteredBackground
{
    NSLog(@"appEnteredBackground");
}

- (void) loadLatestFeedData
{
    
    [self startLoadingAnimation];
    
    switch (_feedSelection.feedType)
    {
        case kCurrent:
            _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
            _title = @"SETH GODIN";
            self.titleLabel.text = _title;
            break;
        case kArchive:
            _contentGetter = [[SGArchiveBlogItemsGetter alloc] initWithMonth:_feedSelection.month andYear:_feedSelection.year];
            
            _title = [self monthYearString];
            self.titleLabel.text = _title;
            
            break;
        case kFavorites:
            _contentGetter = [[SGFavoritesBlogItemsGetter alloc] init];
            _title = @"FAVORITES";
            self.titleLabel.text = _title;
            break;
        case kSearch:
            _contentGetter = [[SGSearchBlogItemsGetter alloc] initWithSearchText:_feedSelection.searchText];
            break;
        default:
             _title = @"SETH GODIN";
            _contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
            self.titleLabel.text = _title;
            break;
    }
    
    if(_messageView)
    {
        [_messageView removeFromSuperview];
        _messageView = nil;
    }

    if(_feedSelection.feedType == kCurrent)
    {
        if(!self.isNetworkingAvailable)
        {
            [self stopLoadingAnimation];
            
            NSArray *cacheItems = _contentGetter.cachedItems;
            if(cacheItems.count < 1)
            {
                [self showNoNetwork];
            }
            else
            {
                [self updateBlogItems:cacheItems];
            }
            
            return;
        }
    }
    
    [_contentGetter requestItemssuccess:^(NSArray *inItems)
     {
         [self stopLoadingAnimation];
         _lastDateLeftView = [NSDate date];
         [self updateBlogItems:inItems];
     } failed:^(NSError *inError)
     {
         NSString *errorMessage = [NSString stringWithFormat:@"Error for feedselection %@", _feedSelection];
         NSLog(@"Error getting data %@", errorMessage);
         [Flurry logError:@"Content Getter Error" message:errorMessage error:inError];
         
         if(_feedSelection.feedType != kCurrent)
         {
             [self updateBlogItems:[NSArray array]];
         }
     }];
}

- (void) updateBlogItems:(NSArray*) inBlogItems
{
    
    self.buttonView.backgroundColor = [UIColor itemsBackgroundColor];
    
    _blogItems = inBlogItems;
    
    [self.tableView reloadData];
    
    if(IS_IPAD)
    {
        if(_blogItems.count >= 1)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            
            [self updateDetailForItemAtRow:0];
        }
    }
    
    [self stopLoadingAnimation];
    
    if(_menuViewController)
    {
        if(_feedSelection.feedType != kCurrent)
        {
            [self closeMenuWithAnimation:NO];
        }
    }
    
    if(inBlogItems.count == 0)
    {
        if(_feedSelection.feedType == kSearch)
        {
            [self showNoSearchResults];
        }
        else if(_feedSelection.feedType == kFavorites)
        {
            [self showNoFavorites];
        }
        else if(_feedSelection.feedType == kArchive)
        {
            [self showNoArchives];
        }
    }
    
    [self animateButtonsComingDown];
}

- (NSString*) monthYearString
{
    SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    NSString *monthStr = [appDelegate.dateFormatterLongStyle.shortMonthSymbols objectAtIndex:_feedSelection.month - 1];
    
    return [NSString stringWithFormat:@"%@ %d", [monthStr uppercaseString], _feedSelection.year];
}


#pragma mark -
#pragma mark animation

- (void) startLoadingAnimation
{
    if(IS_IPHONE)
    {
        [_loadingAnimation startLoadingAnimation];
    }
    else
    {
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_keyWindow animated:YES];
        hud.labelText = @"Loading...";
    }
}

- (void) stopLoadingAnimation
{
    if(IS_IPHONE)
    {
        [_loadingAnimation stopLoadingAnimation];
    }
    else
    {
        [MBProgressHUD hideHUDForView:_keyWindow animated:YES];
    }
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

- (void) animateButtonsComingDown
{

    if(self.buttonView.frame.origin.y > 0) return; //Already in the down position.
    
    if(_blogItems.count > 0)
    {
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationCurveEaseInOut animations:^
         {
             self.buttonViewToTopViewConstraint.constant += 500;
             [self.view layoutSubviews];
         }
                         completion:nil];
    }
    else
    {
        self.buttonViewToTopViewConstraint.constant += 500;
        [self.view layoutSubviews];
    }
}


#pragma mark -
#pragma mark searching

- (BOOL) isInSearchState
{
    return (self.searchTextField.hidden == NO);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.text.length <= 2) return NO;
    [self searchBlogFor:textField.text];
    return [textField resignFirstResponder];
}

- (void) searchBlogFor:(NSString*) inText
{
    SGFeedSelection *feedSelection = [SGFeedSelection selectionAsSearch:inText];
    [SGNotifications postFeedSelection:feedSelection];
    [self.searchTextField resignFirstResponder];
}

- (void) closeSearchView
{
   [self hideMessage];
    
   [self.searchTextField resignFirstResponder];
   self.searchTextField.hidden = YES;
   self.titleLabel.hidden = NO;
   
   self.titleLabel.text = _title;
    
   [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
   [self fadeToolbarAnimation];
    
    if(_itemsHold)
    {
        _blogItems = _itemsHold;
        [self.tableView reloadData];
    }
    else
    {
        //Maybe there wasn't any data before the search.
        //need to show something, so go back to current data.
        _feedSelection.feedType = kCurrent;
        [self loadLatestFeedData];
    }
    
    _itemsHold = nil;

}

- (IBAction)searchAction:(id)sender
{
    if(!self.searchTextField.hidden) return;
    
    self.titleLabel.hidden = YES;
    if(!_itemsHold)
    {
        _itemsHold = _blogItems;
    }
    
    [SGNotifications postMenuSelectedNotification:NO];
    
    self.searchTextField.hidden = NO;
    
    [self.menuButton setImage:[UIImage closeButton] forState:UIControlStateNormal];
    self.titleLabel.hidden = YES;
    [self.searchTextField becomeFirstResponder];
    [self fadeToolbarAnimation];
}


#pragma mark -
#pragma mark user messages

- (void) askToUseCloud
{
    [self performSegueWithIdentifier:@"askToUseCloud" sender:self];
}

- (void) showNoNetwork
{
    [self showWarningMessage:@"Please connect to the internet. Once you've done this, we'll do some fancy technical stuff so you can read offline."];
}

- (void) showNoSearchResults
{
    [self showWarningMessage:@"Hmm, your search didn't return any results."];
}

- (void) showNoFavorites
{
   [self showWarningMessage:@"No favorites yet? Tap the heart in any post to mark as a favorite."];  
}

- (void) showNoArchives
{
    NSString *message = [NSString stringWithFormat:@"Hmm, there doesn't seem to be any archived post for %@", [self monthYearString]];
    [self showWarningMessage:message];
}

- (void) hideMessage
{
    if(!_messageView) return;
    [_messageView removeFromSuperview];
    _messageView = nil;
}

- (void) showWarningMessage:(NSString*) inMessage
{
    [_messageView removeFromSuperview];
    
    _messageView = [[UIView alloc] init];
    _messageView.backgroundColor = [UIColor messageBackgroundColor];
    
    _messageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_messageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_messageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:_messageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:_messageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];

    [self.view addSubview:_messageView];
    [self.view addConstraints:@[topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    messageLabel.font = [UIFont messageTextFont];
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = [UIColor messsageTextColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.text = inMessage;
    
    leadingConstraint = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:20];
    
    trailingConstraint = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-20];
    
    topConstraint = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_messageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    bottomConstraint = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_messageView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    
    [_messageView addSubview:messageLabel];
    [self.view addConstraints:@[leadingConstraint, trailingConstraint, topConstraint, bottomConstraint]];
    
    [self.view layoutIfNeeded];
    
}

#pragma mark -
#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _blogItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGBlogEntry *blogEntry = _blogItems[indexPath.row];
    
    CGSize size = [blogEntry.title sizeWithFont:_titleFont constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, 44) + 60;
    
    if(indexPath.row == 0)
    {
        height += 10;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SGBlogEntryCell *cell = (SGBlogEntryCell*) [tableView dequeueReusableCellWithIdentifier:BLOG_ENTRY_CELL forIndexPath:indexPath];
    
    
    if(indexPath.row == 0)
    {
        cell.textToTopViewConstraint.constant = 10;
    }
    
    cell.blogEntry = _blogItems[indexPath.row];
    
    [cell layoutIfNeeded];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateDetailForItemAtRow:indexPath.row];
}

- (void) updateDetailForItemAtRow:(NSUInteger) inRow
{
    _blogEntry = _blogItems[inRow];
    
    if(IS_IPHONE)
    {
        [self performSegueWithIdentifier:SEGUE_TO_POST sender:nil];
    }
    
    [SGNotifications postBlogEntrySelected:_blogEntry];
}

@end
