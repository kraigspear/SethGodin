//
//  SGFavoritesDocument.m
//  SethGodin
//
//  Created by Kraig Spear on 12/14/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavoritesDocument.h"
#import "SGNotifications.h"

NSString * const KEY_CLOUD_DATA = @"cloudData";

@implementation SGFavoritesDocument

#pragma mark -
#pragma mark UIDocument
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
    
    [SGNotifications postFavoritesUpdated];
    
    return YES;
}

- (id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    if(!self.cloudData) self.cloudData = [[SGFavorites alloc] init];
    return [NSKeyedArchiver archivedDataWithRootObject:self.cloudData];
}

#pragma mark -
#pragma mark NSCoding
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cloudData forKey:KEY_CLOUD_DATA];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    
    if(self)
    {
        self.cloudData = [aDecoder decodeObjectForKey:KEY_CLOUD_DATA];
    }
    
    return self;
}

- (void) saveDocument
{
    [self saveToURL:self.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success)
    {
        [SGNotifications postFavoritesUpdated];
    }];
}

#pragma mark -
#pragma mark URL
+ (NSURL*) localURL
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL*) ubiquitousURL
{
    return [[[NSFileManager defaultManager]
             URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents"];
}





@end
