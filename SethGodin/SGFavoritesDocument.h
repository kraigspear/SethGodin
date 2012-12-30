//
//  SGFavoritesDocument.h
//  SethGodin
//
//  Created by Kraig Spear on 12/14/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGFavorites.h"

#import "BlockTypes.h"

extern NSString * const kFILENAME;

@interface SGFavoritesDocument : UIDocument

@property (atomic, strong) SGFavorites *cloudData;

/**
 Save the document to the URL that has been set.
 */
- (void) saveDocument;


/**
 Where the local file is stored
 */
+ (NSURL*) localURL;

/**
 Yes if the local file exist.
 */
+ (BOOL) localFileExist;

/**
 Where the remote file is stored.
 */
+ (NSURL*) ubiquitousURL;

/**
 Move a local copy of favorites to iCloud
 */
+ (void) moveLocalToiCloudSuccess:(BOOLBlock) success;

/**
 Move a iCloud favorites to local
 */
+ (void) moveICloudToLocal;

@end
