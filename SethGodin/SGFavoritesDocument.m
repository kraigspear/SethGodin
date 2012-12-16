//
//  SGFavoritesDocument.m
//  SethGodin
//
//  Created by Kraig Spear on 12/14/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavoritesDocument.h"

@implementation SGFavoritesDocument

- (BOOL) loadFromContents:(id) contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    //Either load data coming into us, or create a new instance.
    if([contents length] > 0)
    {
        self.cloudData = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
    }
    else
    {
        self.cloudData = [[SGFavorites alloc] init];
    }
    
    [PDLNotifications postNotesUpdated];
    
    return YES;
}


@end
