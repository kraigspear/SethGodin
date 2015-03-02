//
//  SGBookCellView.m
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGBookCellView.h"
#import "SGPurchaseItem.h"

@implementation SGBookCellView

NSString * const KEY_PATH_IMAGE = @"image";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setPurchaseItem:(SGPurchaseItem *)purchaseItem
{
    [self.purchaseItem removeObserver:self forKeyPath:KEY_PATH_IMAGE];
    _purchaseItem = purchaseItem;
    self.imageView.image = purchaseItem.image;
    [self.purchaseItem addObserver:self forKeyPath:KEY_PATH_IMAGE options:NSKeyValueObservingOptionNew context:nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:KEY_PATH_IMAGE])
    {
        self.imageView.image = self.purchaseItem.image;
        [self.parentView reloadData];
    }
}

- (void) dealloc
{
    [self.purchaseItem removeObserver:self forKeyPath:KEY_PATH_IMAGE];
    _purchaseItem = nil;
}

@end
