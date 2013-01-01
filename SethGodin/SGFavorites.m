//
//  SGFavorites.m
//  SethGodin
//
//  Created by Kraig Spear on 11/13/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavorites.h"
#import <CoreData/CoreData.h>
#import "SGBlogEntry.h"
#import "NSFileManager+Util.h"
#import "SGNotifications.h"

@implementation SGFavorites
{
@private
    NSMutableArray *_favorites;
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel         *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    
}

NSString * const KEY_FAVORITES = @"favorites";

@synthesize favorites = _favorites;

+ (SGFavorites*) sharedInstance
{
    static SGFavorites *instance;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      instance = [[SGFavorites alloc] init];
                  });
    
    return instance;
}


- (id) init
{
    self = [super init];
    
    if(self)
    {
        _favorites = [NSMutableArray array];
    }
    
    return self;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [[SGFavorites alloc] init];
    
    _favorites = [aDecoder decodeObjectForKey:KEY_FAVORITES];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_favorites forKey:KEY_FAVORITES];
}


- (void) saveFavorites
{
    [NSKeyedArchiver archiveRootObject:self toFile:[SGFavorites filePathName]];
}

- (void) loadFavorites
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:context];
    
    NSError *error;
    fetchRequest.entity = entity;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    for(NSManagedObject *mangedObject in results)
    {
        NSLog(@"managedObject %@", mangedObject);
    }
    
    
  //  NSString *fileNamePath = [SGFavorites filePathName];
    
//    if([[NSFileManager defaultManager] fileExistsAtPath:fileNamePath])
//    {
//        return [NSKeyedUnarchiver unarchiveObjectWithFile:fileNamePath];
//    }
//    else
//    {
//        return [[SGFavorites alloc] init];
//    }
}



+ (NSString*) filePathName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:@"favorites.dat"];
}

- (void) addBlogEntry:(SGBlogEntry *)inEntry
{
    if([self containsBlogEntry:inEntry]) return;
    [_favorites insertObject:inEntry atIndex:0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSManagedObjectContext *context = [self managedObjectContext];
                       
                       NSManagedObject *managedFavorite = [NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:context];
                       
                       [managedFavorite setValue:inEntry.summary forKey:@"content"];
                       [managedFavorite setValue:inEntry.title forKey:@"title"];
                       [managedFavorite setValue:inEntry.datePublished forKey:@"date"];
                       [managedFavorite setValue:inEntry.summary forKey:@"summary"];
                       [managedFavorite setValue:inEntry.itemID forKey:@"id"];
                       [managedFavorite setValue:inEntry.urlStr forKey:@"url"];
                       
                       NSError *error;
                       if(![context save:&error])
                       {
                           NSLog(@"Error saving favorite %@", error.localizedDescription);
                       }
                       else
                       {
                           NSLog(@"saved!!!!");
                       }

                   });
        
    [self saveFavorites];
}

- (void) removeBlogEntry:(SGBlogEntry*) inEntry
{
    [_favorites removeObject:inEntry];
    [self saveFavorites];
}

- (BOOL) containsBlogEntry:(SGBlogEntry*) inEntry
{
    return [_favorites containsObject:inEntry];
}

#pragma mark -
#pragma mark iCloud core data

- (NSManagedObjectContext *)managedObjectContext
{
    
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel
{
    
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    
    
    NSURL *storeURL = [NSFileManager URLOfFileInDocumentPathWithFileName:@"favorites.sqllite"];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
          
                                                   configuration:nil URL:storeURL options:nil error:&error])
    {
        [SGNotifications postErrorOccured:error];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}


- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString*) applicationDocumentsDirectoryString
{
    NSArray *documentDirectories =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [documentDirectories objectAtIndex:0];
}


@end
