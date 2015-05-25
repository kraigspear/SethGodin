//
//  SGViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogEntriesViewController.h"
#import "UIImage+RSSSelection.h"

#import "AFNetworkReachabilityManager.h"

#import "SGBlogEntry.h"
#import "SGBlogEntryViewController.h"
#import "SGAppDelegate.h"
#import "UIImage+General.h"
#import "SGMenuViewController.h"
#import "SGNotifications.h"
#import "SGFavoritesBlogItemsGetter.h"
#import "SGCurrentBlogItemsGetter.h"
#import "SGArchiveBlogItemsGetter.h"
#import "UIColor+General.h"
#import "SGSearchBlogItemsGetter.h"
#import "SGLoadingAnimation.h"
#import "SGPurchaseItem.h"
#import "NSDate+General.h"

#import "UIFont+General.h"
#import "NSDate+General.h"

#import "MBProgressHUD.h"

#import "SGBlogEntryCell.h"
#import "NSDate+Util.h"


#import <Parse/Parse.h>

#define BLOG_ENTRY_CELL @"blogEntryCell"
#define PURCHASE_ITEM_CELL @"purchaseItemCell"

@interface SGBlogEntriesViewController ()

@end

static SGBlogEntriesViewController *instance = nil;

@implementation SGBlogEntriesViewController
{
@private
  NSMutableArray *_feedItems;
  
  FeedItem *_feedItem;
  
  NSLayoutConstraint *_menuTopConstraint;
  NSLayoutConstraint *_menuBottomConstraint;
  
  SGFeedSelection *_feedSelection;
  
  SGMenuViewController *_menuViewController;
  
  SGLoadingAnimation *_loadingAnimation;
  
  NSArray *_itemsHold;
  NSString *_feedTitle;
  
  UIView *_messageView;
  
  NSDate *_lastDateLeftView;
  
  __weak UIWindow *_keyWindow;
  
  //When the
  NSDate *_blogLatestLastLoaded;
  
  id _feedSelectionNotification;
  id _favoriteDeletedNotification;
  id _addFavoritesAddedNotification;
  id _newContentNotification;
  
  BookPurchaser *_bookPurchaser;
}

+ (instancetype) sharedInstance
{
  return instance;
}

NSString *const SEGUE_TO_POST = @"viewPostSeque";

- (void)setIsNetworkingAvailable:(BOOL)toValue
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
  NSAssert(instance == nil, @"Already have an instance of self?");
  
  instance = self;
  
  [super viewDidLoad];
  
  _blogLatestLastLoaded = [NSDate dateWithTimeIntervalSince1970:1];
  
  [UIFont fontWithName:@"HelveticaNeue-Bold" size:24];
  
  [self registerBlogEntryCell];
  [self registerPurchaseCell];
  
  self.tableView.estimatedRowHeight = 88.0f;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  
  _feedTitle = @"SETH GODIN";
  
  if (IS_IPHONE)
  {
    _loadingAnimation = [[SGLoadingAnimation alloc] initWithView:self.view topConstraint:self.buttonViewToTopViewConstraint];
  }
  
  _feedSelection = [SGFeedSelection selectionAsCurrent];
  
  self.searchTextField.borderStyle = UITextBorderStyleNone;
  self.searchTextField.returnKeyType = UIReturnKeySearch;
  self.searchTextField.textColor = [UIColor titlebarTextColor];
  
  //Top View
  self.topView.backgroundColor = [UIColor blogEntriesTopBarBackgroundColor];
  self.titleLabel.textColor = [UIColor blogEntriesTextColor];
  self.titleLabel.font = [UIFont blogEntriesTitleFont];
  
  [self.searchButton setImage:[UIImage searchButton] forState:UIControlStateNormal];
  [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
  
  
  _feedSelectionNotification = [SGNotifications observeFeedSelectionWithNotification:^(NSNotification *note)
                                {
                                  SGFeedSelection *newFeedSelection = note.object;
                                  //Moving away from current we DO want the feed to repopulate when moving back.
                                  if(newFeedSelection.feedType != kCurrent)
                                  {
                                    _blogLatestLastLoaded = [NSDate dateWithTimeIntervalSince1970:1];
                                  }
                                  _feedSelection = newFeedSelection;
                                  [self loadLatestFeedData];
                                }];
  
  _favoriteDeletedNotification = [SGNotifications observeFavoriteDeleted:^(NSNotification *notification) {
    [self removeFavoriteFromTableView:notification.object];
  }];
  
  _addFavoritesAddedNotification = [SGNotifications observeFavoriteAdded:^(NSNotification *notification) {
    [self addFavoriteToTableView:notification.object];
  }];
  
  _newContentNotification = [SGNotifications observeNewContent:^(NSNotification *notification) {
    [self loadLatestFeedData];
  }];
  
  __weak SGBlogEntriesViewController *weakSelf = self;
  
  [[AFNetworkReachabilityManager sharedManager] startMonitoring];
  
  if ([AFNetworkReachabilityManager sharedManager].reachable)
  {
    [self loadLatestFeedData];
  }
  
  [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    SGBlogEntriesViewController *strongSelf = weakSelf;
    
    if (strongSelf)
    {
      strongSelf.isNetworkingAvailable = (status == AFNetworkReachabilityStatusReachableViaWWAN) || (status == AFNetworkReachabilityStatusReachableViaWiFi);
      
      [strongSelf loadLatestFeedData];
    }
    
  }];
  
  if (IS_IPHONE)
  {
    [self askToUseCloud];
  }
  
}


- (void)registerBlogEntryCell
{
  UINib *cellNib = [UINib nibWithNibName:@"BlogEntryCell" bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:BLOG_ENTRY_CELL];
}

- (void)registerPurchaseCell
{
  UINib *cellNib = [UINib nibWithNibName:@"PurchaseItemCell" bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:PURCHASE_ITEM_CELL];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (_lastDateLeftView)
  {
    if ([_lastDateLeftView numberOfMinutesSince] > 30)
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
}


#pragma mark -
#pragma mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if (self.searchTextField.isFirstResponder)
  {
    [self closeSearchView];
  }
  
  if ([segue.identifier isEqualToString:SEGUE_TO_POST])
  {
    _lastDateLeftView = [NSDate date];
    SGBlogEntryViewController *postVC = segue.destinationViewController;
    postVC.blogEntry = self.currentBlogEntry;
  }
}

#pragma mark -
#pragma mark Selected Data Object

- (SGBlogEntry *)currentBlogEntry
{
  if (!_feedItem)
  {
    return nil;
  }
  
  if ([_feedItem.dataObject isKindOfClass:[SGBlogEntry class]])
  {
    return _feedItem.dataObject;
  }
  else
  {
    return nil;
  }
}

- (SGPurchaseItem *)currentPurchaseItem
{
  if (!_feedItem)
  {
    return nil;
  }
  
  if ([_feedItem.dataObject isKindOfClass:[SGPurchaseItem class]])
  {
    return _feedItem.dataObject;
  }
  else
  {
    return nil;
  }
}


#pragma mark -
#pragma mark menu

- (IBAction)menuAction:(id)sender
{
  [self hideMessage];
  
  if ([self isInSearchState])
  {
    [self closeSearchView];
  }
  else
  {
    if (self.menuSelected)
    {
      self.menuSelected();
    }
    [self showMenu];
  }
}


- (void)showMenuiPhone
{
  _menuViewController = (SGMenuViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
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
  
  _menuViewController.close = ^(BOOL shouldAnimate) {
    SGBlogEntriesViewController *strongSelf = weakSelf;
    
    if (strongSelf)
    {
      [strongSelf closeMenuWithAnimation:shouldAnimate];
    }
    
  };
  
  [self.view layoutIfNeeded];
  [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    {
      _menuTopConstraint.constant = 0;
      _menuBottomConstraint.constant = 0;
      [self.view layoutIfNeeded];
    }
  }                completion:^(BOOL finished) {
  }];
  
}

- (void)showMenuiPad
{
  [SGNotifications postMenuSelectedNotification:YES];
}

- (void)showMenu
{
  if (IS_IPHONE)
  {
    [self showMenuiPhone];
  }
  else
  {
    [self showMenuiPad];
  }
}

- (void)closeMenuWithAnimation:(BOOL)inAnimate
{
  if (inAnimate)
  {
    [self animateCloseMenu];
  }
  else
  {
    [self removeMenuController];
  }
}

- (void)animateCloseMenu
{
  [self.view layoutIfNeeded];
  
  __weak typeof(self) weakSelf = self;
  
  [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    _menuTopConstraint.constant = -self.view.frame.size.height;
    _menuBottomConstraint.constant = -self.view.frame.size.height;
    [self.view layoutIfNeeded];
  }
                   completion:^(BOOL finished) {
                     if (finished)
                     {
                       typeof(self) strongSelf = weakSelf;
                       
                       if(strongSelf)
                       {
                         [strongSelf removeMenuController];
                       }
                     }
                   }];
}

- (void)removeMenuController
{
  [_menuViewController.view removeFromSuperview];
  [_menuViewController removeFromParentViewController];
  _menuViewController = nil;
}

#pragma mark -
#pragma mark feed loading

- (void)appEnteredForeground
{
  [self stopLoadingAnimation];
  
  if (self.isViewLoaded && self.view.window)
  {
    //It's not worth refreshing a search, archive ext...
    //only the current feed might change between app sessions.
    if (_feedSelection.feedType == kCurrent)
    {
      [self loadLatestFeedData];
    }
  }
}

- (void)loadLatestFeedData
{
  [self loadLatestFeedData:nil];
}

- (void)loadLatestFeedData:(SWBoolErrorBlock) onComplete
{
  
  [self startLoadingAnimation];
  
  SGBlogItemsGetter *contentGetter;
  
  switch (_feedSelection.feedType)
  {
    case kCurrent:
      contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
      _feedTitle = @"SETH GODIN";
      self.titleLabel.text = _feedTitle;
      break;
    case kArchive:
      contentGetter = [[SGArchiveBlogItemsGetter alloc] initWithMonth:_feedSelection.month andYear:_feedSelection.year];
      
      _feedTitle = [self monthYearString];
      self.titleLabel.text = _feedTitle;
      
      break;
    case kFavorites:
      contentGetter = [[SGFavoritesBlogItemsGetter alloc] init];
      _feedTitle = @"FAVORITES";
      self.titleLabel.text = _feedTitle;
      break;
    case kSearch:
      contentGetter = [[SGSearchBlogItemsGetter alloc] initWithSearchText:_feedSelection.searchText];
      break;
    default:
      _feedTitle = @"SETH GODIN";
      contentGetter = [[SGCurrentBlogItemsGetter alloc] init];
      self.titleLabel.text = _feedTitle;
      break;
  }
  
  if (_messageView)
  {
    [_messageView removeFromSuperview];
    _messageView = nil;
  }
  
  if (_feedSelection.feedType == kCurrent)
  {
    if (!self.isNetworkingAvailable)
    {
      [self stopLoadingAnimation];
      
      NSArray *cacheItems = contentGetter.cachedItems;
      if (cacheItems.count < 1)
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
  
  FeedLoader *feedLoader = [[FeedLoader alloc] initWithBlogItemGetter:contentGetter];
  
  __weak typeof(self) weakSelf = self;
  
  FeedItem *firstFeedItem = [self firstFeedItem];
  
  [feedLoader loadFeed:^(NSArray * feedItems, NSError * error)
   {
     typeof(self) strongSelf = weakSelf;
     
     if(strongSelf)
     {
       [strongSelf stopLoadingAnimation];
       strongSelf->_lastDateLeftView = [NSDate date];
       
       
       if(error)
       {
         NSString *errorMessage = [NSString stringWithFormat:@"Error for feedselection %@", self->_feedSelection];
         NSLog(@"Error getting data %@", errorMessage);
         if(onComplete)
         {
           onComplete(NO, error);
         }
       }
       else if(feedItems)
       {
         [self updateBlogItems:feedItems];
         
         //We only avoid reloading data if it's the current data.
         if(_feedSelection.feedType == kCurrent)
         {
           self->_blogLatestLastLoaded = [NSDate date];
         }
         
         if(onComplete)
         {
           BOOL hasNewData = NO;
           
           if(firstFeedItem)
           {
             FeedItem *newFirstItem = [self firstFeedItem];
             if(newFirstItem)
             {
               hasNewData = ![firstFeedItem.title isEqualToString:newFirstItem.title];
             }
           }
           
           onComplete(hasNewData, nil);
           
         }
       }
     }
   }];
  
  
};

- (FeedItem*) firstFeedItem
{
  if(!_feedItems)
    return nil;
  if(_feedItems.count < 1)
    return nil;
  return _feedItems[0];
}

- (void)updateBlogItems:(NSArray *)inBlogItems
{
  
  self.buttonView.backgroundColor = [UIColor itemsBackgroundColor];
  
  _feedItems = [inBlogItems mutableCopy];
  
  [self.tableView reloadData];
  
  
  if (IS_IPAD)
  {
    if (_feedItems.count >= 1)
    {
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
      
      [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
      
      [self showViewForRow:0];
    }
  }
  
  [self stopLoadingAnimation];
  
  if (_menuViewController)
  {
    if (_feedSelection.feedType != kCurrent)
    {
      [self closeMenuWithAnimation:NO];
    }
  }
  
  if (inBlogItems.count == 0)
  {
    if (_feedSelection.feedType == kSearch)
    {
      [self showNoSearchResults];
    }
    else if (_feedSelection.feedType == kFavorites)
    {
      [self showNoFavorites];
    }
    else if (_feedSelection.feedType == kArchive)
    {
      [self showNoArchives];
    }
  }
  
  [self animateButtonsComingDown];
}

- (NSString *)monthYearString
{
  SGAppDelegate *appDelegate = (SGAppDelegate *) [[UIApplication sharedApplication] delegate];
  
  NSString *monthStr = appDelegate.dateFormatterLongStyle.shortMonthSymbols[_feedSelection.month - 1];
  
  return [NSString stringWithFormat:@"%@ %lu", [monthStr uppercaseString], (unsigned long) _feedSelection.year];
}


#pragma mark -
#pragma mark animation

- (void)startLoadingAnimation
{
  if (IS_IPHONE)
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

- (void)stopLoadingAnimation
{
  if (IS_IPHONE)
  {
    [_loadingAnimation stopLoadingAnimation];
  }
  else
  {
    [MBProgressHUD hideHUDForView:_keyWindow animated:YES];
  }
}

- (void)fadeToolbarAnimation
{
  CATransition *animation = [CATransition animation];
  animation.delegate = self;
  animation.duration = .25f;
  animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  animation.type = kCATransitionFade;
  
  [self.topView exchangeSubviewAtIndex:0 withSubviewAtIndex:0];
  [self.topView.layer addAnimation:animation forKey:@"animation"];
}

- (void)animateButtonsComingDown
{
  
  if (self.buttonView.frame.origin.y > 0) return; //Already in the down position.
  
  if (_feedItems.count > 0)
  {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
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

- (BOOL)isInSearchState
{
  return !self.searchTextField.hidden;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  if (textField.text.length <= 2) return NO;
  [self searchBlogFor:textField.text];
  return [textField resignFirstResponder];
}

- (void)searchBlogFor:(NSString *)inText
{
  SGFeedSelection *feedSelection = [SGFeedSelection selectionAsSearch:inText];
  [SGNotifications postFeedSelection:feedSelection];
  [self.searchTextField resignFirstResponder];
}

- (void)closeSearchView
{
  [self hideMessage];
  
  [self.searchTextField resignFirstResponder];
  self.searchTextField.hidden = YES;
  self.titleLabel.hidden = NO;
  
  self.titleLabel.text = _feedTitle;
  
  [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
  [self fadeToolbarAnimation];
  
  if (_itemsHold)
  {
    _feedItems = [_itemsHold mutableCopy];
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
  if (!self.searchTextField.hidden) return;
  
  self.titleLabel.hidden = YES;
  if (!_itemsHold)
  {
    _itemsHold = _feedItems;
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

- (void)askToUseCloud
{
  if (![PFUser currentUser])
  {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"account"];
    [self.navigationController pushViewController:vc animated:NO];
  }
}

- (void)showNoNetwork
{
  [self showWarningMessage:@"Please connect to the internet. Once you've done this, we'll do some fancy technical stuff so you can read offline."];
}

- (void)showNoSearchResults
{
  [self showWarningMessage:@"Hmm, your search didn't return any results."];
}

- (void)showNoFavorites
{
  [self showWarningMessage:@"No favorites yet? Tap the heart in any post to mark as a favorite."];
}

- (void)showNoArchives
{
  NSString *message = [NSString stringWithFormat:@"Hmm, there doesn't seem to be any archived post for %@", [self monthYearString]];
  [self showWarningMessage:message];
}

- (void)hideMessage
{
  if (!_messageView) return;
  [_messageView removeFromSuperview];
  _messageView = nil;
}

- (void)showWarningMessage:(NSString *)inMessage
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
#pragma mark UITableView

- (void)addFavoriteToTableView:(SGBlogEntry *)blogEntry
{
  if (_feedSelection.feedType != kFavorites) return;
  [_feedItems insertObject:blogEntry atIndex:0];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView beginUpdates];
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
  [self.tableView endUpdates];
}

- (void)removeFavoriteFromTableView:(SGBlogEntry *)blogEntry
{
  if (_feedSelection.feedType != kFavorites) return;
  NSUInteger itemIndex = [_feedItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isEqual:blogEntry])
    {
      *stop = YES;
      return YES;
    }
    else
    {
      return NO;
    }
  }];
  
  if (itemIndex == NSNotFound) return;
  
  [_feedItems removeObjectAtIndex:itemIndex];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:0];
  [self.tableView beginUpdates];
  [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
  [self.tableView endUpdates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _feedItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  FeedItem *feedItem = _feedItems[indexPath.row];
  
  UITableViewCell *cell;
  
  if ([feedItem.dataObject isKindOfClass:[SGBlogEntry class]])
  {
    SGBlogEntryCell *blogEntryCell = (SGBlogEntryCell *) [tableView dequeueReusableCellWithIdentifier:BLOG_ENTRY_CELL forIndexPath:indexPath];
    
    blogEntryCell.blogEntry = feedItem.dataObject;
    
    if (indexPath.row == 0)
    {
      blogEntryCell.textToTopViewConstraint.constant = 10;
    }
    
    cell = blogEntryCell;
  }
  else if ([feedItem.dataObject isKindOfClass:[SGPurchaseItem class]])
  {
    SGPurchaseItemCell *purchaseItemCell = (SGPurchaseItemCell *) [tableView dequeueReusableCellWithIdentifier:PURCHASE_ITEM_CELL forIndexPath:indexPath];
    
    purchaseItemCell.purchaseItem = feedItem.dataObject;
    cell = purchaseItemCell;
  }
  else
  {
    NSAssert(NO, @"FeedItem type not implemented");
  }
  
  [cell layoutIfNeeded];
  
  return cell;
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self showViewForRow:(NSUInteger) indexPath.row];
}

/**
 * Show a view for the selection for either blog content or a book purchase.
 */
- (void)showViewForRow:(NSUInteger)inRow
{
  _feedItem = _feedItems[inRow];
  
  SGBlogEntry *blogEntry = self.currentBlogEntry;
  SGPurchaseItem *purchaseItem = self.currentPurchaseItem;
  
  
  if (IS_IPHONE && blogEntry)
  {
    [self performSegueWithIdentifier:SEGUE_TO_POST sender:nil];
  }
  
  if (blogEntry)
  {
    if([blogEntry.datePublished isSameDayAs:[NSDate date]])
    {
      [Analytics logViewBlogToday];
    }
    else
    {
      [Analytics logViewBlogNotToday];
    }
    
    [SGNotifications postBlogEntrySelected:self.currentBlogEntry];
  }
  else if (purchaseItem)
  {
    [self showPurchaseBook];
  }
  
}

- (void) showError:(NSError*) inError
{
  UIAlertController *alert = [[UIAlertController alloc] init];
  alert.title = @"Error";
  alert.message = inError.localizedDescription;
  
  
  UIAlertAction *cancelAction =  [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                  {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                  }];
  
  [alert addAction:cancelAction];
  
  
  [self presentViewController:alert animated:YES completion:nil];
}

- (void) showMessageTitle:(NSString*) title message:(NSString*) message
{
  UIAlertController *alert = [[UIAlertController alloc] init];
  alert.title = title;
  alert.message = message;
  
  UIAlertAction *cancelAction =  [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                  {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                  }];
  [alert addAction:cancelAction];
  [self presentViewController:alert animated:YES completion:nil];
  
}

#pragma mark -
#pragma mark Purchase book

- (void)showPurchaseBook
{
  __weak typeof(self) weakSelf = self;
  
  SGPurchaseItem *purchaseItem = self.currentPurchaseItem;
  if (!purchaseItem)
  {
    return;
  }
  
  [Analytics logPurchaseTap:purchaseItem.title];
  
  _bookPurchaser = [[BookPurchaser alloc] initWithPurchaseItem:purchaseItem parentViewController:self completed:^(NSError *error)
                                  {
                                    typeof(self) strongSelf = weakSelf;
                                    
                                    if(strongSelf)
                                    {
                                     
                                      if(error)
                                      {
                                        [Analytics logPurchaseError:error];
                                        [strongSelf showError:error];
                                      }
                                      
                                      strongSelf->_bookPurchaser = nil;
                                    }
                                  }];
  
  [_bookPurchaser purchase];
}

- (void) dispose
{
  [[NSNotificationCenter defaultCenter] removeObserver:_feedSelectionNotification];
  [[NSNotificationCenter defaultCenter] removeObserver:_favoriteDeletedNotification];
  [[NSNotificationCenter defaultCenter] removeObserver:_addFavoritesAddedNotification];
  [[NSNotificationCenter defaultCenter] removeObserver:_newContentNotification];
}

@end
