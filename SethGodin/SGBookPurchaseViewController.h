//
//  SGBookPurchaseViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/17/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBlogItemsGetter.h"

@interface SGBookPurchaseViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
