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
#import "BlockTypes.h"
#import "SGBookCellView.h"
#import "SGLoadingAnimation.h"
#import "UIImage+General.h"
#import "BlockAlertView.h"
#import <QuartzCore/QuartzCore.h>


@implementation SGBookPurchaseViewController
{
@private
    SGPurchaseItemGetter   *_purchaseItemGetter;
    NSArray *_items;
    SKStoreProductViewController *_storeProductViewController;
    SGLoadingAnimation *_loadingAnimation;
    BlockAlertView *_alertView;
}

NSString * const ReuseIdentifier = @"bookCell";

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"BOOKS" usingBackgroundColor:[UIColor whiteColor]]];
    
    if(IS_IPHONE5)
    {
        self.backgroundImageView.image = [UIImage imageNamed:@"books-568h.png"];
    }
    else
    {
        self.backgroundImageView.image = [UIImage imageNamed:@"books-iphone4.png"];
    }
        
    [self.backButton setImage:[UIImage backButton] forState:UIControlStateNormal];
    
    _loadingAnimation = [[SGLoadingAnimation alloc] initWithView:self.view topConstraint:nil];
    self.collectionViewToTrailing.constant = 320;
    self.collectionViewToLeading.constant = 320;
    [self.view layoutSubviews];
    
    UINib *cellNib = [UINib nibWithNibName:@"BookCellView" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:ReuseIdentifier];
    
    _purchaseItemGetter = [[SGPurchaseItemGetter alloc] init];
    
    [_loadingAnimation startLoadingAnimation];
    [_purchaseItemGetter latestItems:^(NSArray *latestItems)
    {
        _items = latestItems;
        [self.collectionView reloadData];
        [self.view layoutSubviews];
        
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^
        {
            [_loadingAnimation stopLoadingAnimation];
            self.collectionViewToTrailing.constant = 0;
            self.collectionViewToLeading.constant = 0;
            [self.view layoutSubviews];
        } completion:^(BOOL completed)
        {
            
        }];
         
        
    } failed:^(NSError *error)
    {
        [self showError:error];
    }];
    
}

- (void) showError:(NSError*) inError
{
    _alertView = [BlockAlertView alertWithTitle:@"Error" message:inError.localizedDescription];
    
    __weak SGBookPurchaseViewController *weakSelf = self;
    
    [_alertView setCancelButtonWithTitle:@"Ok" block:^
    {
        SGBookPurchaseViewController *strongSelf = weakSelf;
        if(strongSelf)
        {
            strongSelf->_alertView = nil;
        }
    }];
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return CGSizeMake(132, 200);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_loadingAnimation startSpinner];
    
    SGPurchaseItem *itemToPurchase = [_items objectAtIndex:indexPath.row];
    
    _storeProductViewController = [[SKStoreProductViewController alloc] init];
    _storeProductViewController.delegate = self;
    
    NSNumber *productNumber = [NSNumber numberWithInteger:itemToPurchase.trackID];
    
    NSDictionary *vcParam = @{SKStoreProductParameterITunesItemIdentifier : productNumber};
    
    [_storeProductViewController loadProductWithParameters:vcParam completionBlock:^(BOOL result, NSError *error)
    {
        if(result && error == nil)
        {
            [self presentViewController:_storeProductViewController animated:YES completion:^
            {
                [_loadingAnimation stopSpinner];
            }];
        }
    }];
    
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



@end
