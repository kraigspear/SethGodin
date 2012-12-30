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
NSString * const kFILENAME = @"favorites.dox";

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
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [url URLByAppendingPathComponent:kFILENAME];
}

+ (BOOL) localFileExist
{
    return [[SGFavoritesDocument localURL] checkResourceIsReachableAndReturnError:nil];
}

+ (NSURL*) ubiquitousURL
{
    NSURL *ubig = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    NSURL *ubiqPackage = [[ubig
                           URLByAppendingPathComponent:@"Documents"]
                           URLByAppendingPathComponent:kFILENAME];
    
    return ubiqPackage;
}


+ (void) moveLocalToiCloudSuccess:(BOOLBlock) success;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSFileManager *fileManager = [NSFileManager defaultManager];
                       NSError *error;
                       
                       if([fileManager setUbiquitous:YES itemAtURL:[SGFavoritesDocument localURL] destinationURL:[SGFavoritesDocument ubiquitousURL] error:&error])
                       {
                           success(YES);
                           NSLog(@"Favorites moved to iCloud");
                       }
                       else
                       {
                           success(NO);
                           NSLog(@"Error moving to iCloud %@", error.localizedDescription);
                       }
                   });
}

+ (void) moveICloudToLocal
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSFileManager *fileManager = [NSFileManager defaultManager];
                       NSError *error;

                       if([fileManager setUbiquitous:NO itemAtURL:[SGFavoritesDocument ubiquitousURL] destinationURL:[SGFavoritesDocument localURL] error:&error])
                       {
                           NSLog(@"Favorites moved to iCloud");
                       }
                       else
                       {
                           NSLog(@"Error moving to iCloud %@", error.localizedDescription);
                       }
                   });
}




@end
