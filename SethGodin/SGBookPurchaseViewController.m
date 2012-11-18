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
#import "BlockAlertView.h"
#import "SGBookCellView.h"

@implementation SGBookPurchaseViewController
{
@private
    UITapGestureRecognizer *_tapGesture;
    SGPurchaseItemGetter   *_purchaseItemGetter;
    BlockAlertView *_alertView;
    NSArray *_items;
}

NSString * const ReuseIdentifier = @"bookCell";

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"BookCellView" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:ReuseIdentifier];
    
    _purchaseItemGetter = [[SGPurchaseItemGetter alloc] init];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
    _tapGesture.numberOfTapsRequired = 1;
    [self.backgroundImageView addGestureRecognizer:_tapGesture];
    
    [_purchaseItemGetter latestItems:^(NSArray *latestItems)
    {
        _items = latestItems;
        [self.collectionView reloadData];
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

- (void) imageViewTap:(id) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return CGSizeMake(106.666666667, 200);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}
//




@end
