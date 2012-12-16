//
//  SGFavoritesDocument.h
//  SethGodin
//
//  Created by Kraig Spear on 12/14/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFavorites.h"


@interface SGFavoritesDocument : UIDocument

@property (atomic, strong) SGFavorites *cloudData;

@end
