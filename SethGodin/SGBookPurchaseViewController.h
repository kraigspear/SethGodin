//
//  SGBookPurchaseViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogItemsGetter.h"
#import <StoreKit/StoreKit.h>
#import "SGTitleView.h"

@interface SGBookPurchaseViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SKStoreProductViewControllerDelegate, SGTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewToTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewToLeading;
@property (weak, nonatomic) IBOutlet SGTitleView *topView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
