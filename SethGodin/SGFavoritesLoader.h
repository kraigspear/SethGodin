//
//  SGFavoritesLoader.h
//  SethGodin
//
//  Created by Kraig Spear on 12/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGFavoritesDocument;

@interface SGFavoritesLoader : NSObject

@property (nonatomic, strong) SGFavoritesDocument *favoritesDoc;

+ (SGFavoritesLoader*) sharedInstance;

/**
 Loads the document either from iCloud or locally
 */
- (void) loadDocument;

@end
