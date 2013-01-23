//
//  SGBookCellView.h
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGPurchaseItem;

@interface SGBookCellView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) UICollectionView *parentView;

@property (nonatomic, strong) SGPurchaseItem *purchaseItem;

@end
