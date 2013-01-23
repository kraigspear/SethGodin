//
//  SGBookPurchaseVerticalViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 1/23/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGBookPurchaseVerticalViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
