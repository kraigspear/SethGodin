//
//  SGFavoritesLoader.m
//  SethGodin
//
//  Created by Kraig Spear on 12/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavoritesLoader.h"
#import "SGFavoritesDocument.h"
#import "SGNotifications.h"
#import "SGUSerDefaults.h"

NSString * const kFILENAME = @"favorites.dox";

@implementation SGFavoritesLoader
{
@private
    NSMetadataQuery *_query;
    id               _currentToken;

}

+ (SGFavoritesLoader*) sharedInstance
{
    static SGFavoritesLoader *instance;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      instance = [[SGFavoritesLoader alloc] init];
                  });
    
    return instance;
}

- (id) init
{
    self = [super init];
    
    _currentToken = [[NSFileManager defaultManager]
                     ubiquityIdentityToken];
    
    return self;
}



- (BOOL) isICloud
{
    if(!_currentToken) return NO;
    return [[SGUserDefaults sharedInstance] useICloud];
}

- (void) loadDocument
{
    
    if(self.isICloud)
    {
        [self loadDocumentFromICloud];
    }
    else
    {
        [self loadDocumentLocally];
    }
    
}

#pragma mark -
#pragma mark loading


- (void) loadDocumentLocally
{
    
    NSArray *documentDirectories =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDir = [documentDirectories objectAtIndex:0];
    
    NSString *filePathAndName = [docDir stringByAppendingPathComponent:kFILENAME];
    NSURL *localURL = [NSURL fileURLWithPath:filePathAndName];
    
    self.favoritesDoc = [[SGFavoritesDocument alloc] initWithFileURL:localURL];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePathAndName])
    {
        [self createNewFileLocally];
    }
    else
    {
        [self.favoritesDoc openWithCompletionHandler:^(BOOL success)
         {
             NSLog(@"loaded %d favorites", self.favoritesDoc.cloudData.favorites.count);
             if(success)
             {
                 [SGNotifications postFavoritesUpdated];
             }
             else
             {
                 [self createNewFileLocally];
             }
         }];
    }
}

- (void) createNewFileLocally
{
    NSAssert(self.favoritesDoc != nil, @"FavoritesDoc is nil, can't save");
    
    [self.favoritesDoc saveToURL:self.favoritesDoc.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success)
     {
         if(success)
         {
             [self.favoritesDoc openWithCompletionHandler:^(BOOL success)
              {
                  [SGNotifications postFavoritesCreated];
              }];
         }
     }];

}


#pragma mark iCloud
- (void) loadDocumentFromICloud
{
    _query = [[NSMetadataQuery alloc] init];
    _query.searchScopes = @[NSMetadataQueryUbiquitousDocumentsScope];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", NSMetadataItemFSNameKey, kFILENAME];
    [_query setPredicate:pred];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryDidFinishGathering:) name:NSMetadataQueryDidFinishGatheringNotification object:_query];
    
    [_query startQuery];
    
}

- (void) queryDidFinishGathering:(NSNotification*) inNotification
{
    NSMetadataQuery *query = inNotification.object;
    [query disableUpdates];
    [query stopQuery];
    _query = nil;
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidStartGatheringNotification object:query];
    
    [self loadData:query];
    
}

- (void) loadData:(NSMetadataQuery*) inQuery
{
    NSAssert(inQuery.resultCount <= 1, @"we found more than 1 file");

    if(inQuery.resultCount == 1)
    {
        NSMetadataItem *item = [inQuery resultAtIndex:0];
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        [self loadDocumentFromICloudAtURL:url];
    }
    else
    {
        [self createANewFileOnICloud];
    }
}

- (void) loadDocumentFromICloudAtURL:(NSURL*) inURL
{
    self.favoritesDoc = [[SGFavoritesDocument alloc] initWithFileURL:inURL];
    
    [self.favoritesDoc openWithCompletionHandler:^(BOOL success)
     {
         NSAssert(success, @"Didn't load favorites!!! what do we do!!!!");
         if(success)
         {
             [SGNotifications postFavoritesUpdated];
         }
     }];
}

- (void) createANewFileOnICloud
{
    NSURL *ubig = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    NSURL *ubiqPackage = [[ubig
                           URLByAppendingPathComponent:@"Documents"]
                          URLByAppendingPathComponent:kFILENAME];
    
    self.favoritesDoc = [[SGFavoritesDocument alloc] initWithFileURL:ubiqPackage];
    [self.favoritesDoc saveToURL:self.favoritesDoc.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success)
     {
         if(success)
         {
             [self.favoritesDoc openWithCompletionHandler:^(BOOL success)
              {
                  [SGNotifications postFavoritesUpdated];
              }];
         }
         else
         {
             NSLog(@"failed to open new document");
         }
     }];

}



@end
