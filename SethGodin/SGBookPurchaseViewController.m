//
//  SGBookPurchaseViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBookPurchaseViewController.h"
#import "SGPurchaseItemGetter.h"
#import "SGPurchaseItem.h"
#import "SGBookCellView.h"
#import "SGLoadingAnimation.h"
#import "UIImage+General.h"
#import "BlockAlertView.h"
#import "UIColor+General.h"
#import "MBProgressHud.h"
#import "Seth_Godin-Swift.h"


@implementation SGBookPurchaseViewController
{
@private
    SGPurchaseItemGetter   *_purchaseItemGetter;
    NSArray *_items;
    SKStoreProductViewController *_storeProductViewController;
    SGLoadingAnimation *_loadingAnimation;
    BlockAlertView *_alertView;
    NSLayoutConstraint *_bookToTopConstraint;
    BookPurchaser *_bookPurchaser;
    __weak UIWindow *_keyWindow;
}

NSString * const ReuseIdentifier = @"bookCell";

- (void) viewDidLoad
{
    [super viewDidLoad];

    @weakify(self);
    self.screenName = @"BookPurchase";

    _bookToTopConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    if(!self.verticalMode)
    {
        if(IS_IPHONE5)
        {
            self.backgroundImageView.image = [UIImage imageNamed:@"books-568h.png"];
        }
        else
        {
            self.backgroundImageView.image = [UIImage imageNamed:@"books-iphone4.png"];
        }
    }
    else
    {
        self.backgroundImageView.hidden = YES;
        [self.view removeConstraint:self.collectionViewHeightConstraint];
        
        [self.view addConstraint:_bookToTopConstraint];
        
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView.backgroundColor = [UIColor tableCellBackgroundColor];
    }
    
    if(IS_IPHONE)
    {
        _loadingAnimation = [[SGLoadingAnimation alloc] initWithView:self.view topConstraint:nil];
        self.collectionViewToTrailing.constant = 320;
        self.collectionViewToLeading.constant = 320;
        [self.view layoutSubviews];
    }
    
    UINib *cellNib = [UINib nibWithNibName:@"BookCellView" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:ReuseIdentifier];
    
    _purchaseItemGetter = [[SGPurchaseItemGetter alloc] init];
    
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
    
    [_purchaseItemGetter latestItems:^(NSArray *latestItems)
    {
        @strongify(self);
        _items = latestItems;
        [self.collectionView reloadData];
        [self.view layoutSubviews];
        
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^
        {
            @strongify(self);
            if(IS_IPHONE)
            {
                [_loadingAnimation stopLoadingAnimation];
            }
            else
            {
                [MBProgressHUD hideHUDForView:_keyWindow animated:YES];
            }
            self.collectionViewToTrailing.constant = 0;
            self.collectionViewToLeading.constant = 0;
            [self.view layoutSubviews];
        } completion:^(BOOL completed)
        {
            
        }];
         
        
    } failed:^(NSError *error)
    {
        @strongify(self);
        [self showError:error];
    }];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateConstraintsForOrientation:self.interfaceOrientation];
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark rotation

- (void) updateConstraintsForOrientation:(UIInterfaceOrientation) inOrientation
{
    if(IS_IPHONE)
    {
        if(UIInterfaceOrientationIsPortrait(inOrientation))
        {
            [self.view removeConstraint:_bookToTopConstraint];
            [self.view addConstraint:self.collectionViewHeightConstraint];
            self.backgroundImageView.hidden = NO;
        }
        else
        {
            [self.view removeConstraint:self.collectionViewHeightConstraint];
            [self.view addConstraint:_bookToTopConstraint];
            self.backgroundImageView.hidden = YES;
        }
    }
    else
    {
        self.backgroundImageView.hidden = YES;
    }
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if(IS_IPHONE)
    {
        [self updateConstraintsForOrientation:toInterfaceOrientation];
    }
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if(IS_IPHONE)
    {
        [self.collectionView reloadData];
    }
}


- (void) showError:(NSError*) inError
{
    _alertView = [BlockAlertView alertWithTitle:@"Error" message:inError.localizedDescription];

    @weakify(self);

    [_alertView setCancelButtonWithTitle:@"Ok" block:^
    {
       @strongify(self);
        self->_alertView = nil;
    }];
}

#pragma mark -
#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SGBookCellView *bookCellView = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
    
    SGPurchaseItem *purchaseItem = [_items objectAtIndex:indexPath.row];
    
    bookCellView.purchaseItem = purchaseItem;
    bookCellView.parentView = collectionView;
    
    return bookCellView;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //size = 298x450 = 152
    //return CGSizeMake(106.666666667, 200);
    // 149 : 225
    
    if(IS_IPHONE)
    {
        if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
        {
            return CGSizeMake(132, 199);
        }
        else
        {
            return CGSizeMake(collectionView.frame.size.height / 1.5, collectionView.frame.size.height);
        }
    }
    else
    {
        return CGSizeMake(320, 489.80);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    @weakify(self);

    SGPurchaseItem *itemToPurchase = _items[indexPath.row];
    
    _bookPurchaser = [[BookPurchaser alloc] initWithPurchaseItem:itemToPurchase parentViewController:self completed:^(NSError *error)
    {
        @strongify(self);

        if (error)
        {
            UIAlertController *alert = [[UIAlertController alloc] init];
            alert.title = @"Error";
            alert.message = error.localizedDescription;

            UIAlertAction *cancelAction =  [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                            {
                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                            }];

            [alert addAction:cancelAction];

            [self presentViewController:alert animated:YES completion:nil];
        }
        
        self->_bookPurchaser = nil;
    }];
    
    [_bookPurchaser purchase];
}


#pragma mark -
#pragma mark SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^
    {
        _storeProductViewController = nil;
    }];
}

#pragma mark -
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"BOOKS";
}

- (void) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage*) leftButtonImage
{
    if(IS_IPHONE)
    {
        return [UIImage backButtonWithColor:[UIColor menuTitleBarTextColor]];
    }
    else
    {
        return nil;
    }
}

- (UIColor*)  titleTextColor
{
    return [UIColor menuTitleBarTextColor];
}

- (UIColor*)  titleViewBackgroundColor
{
    return [UIColor menuTitleBarBackgroundColor];
}


@end
