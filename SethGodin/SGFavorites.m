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
}

NSString * const KEY_FAVORITES = @"favorites";

@synthesize favorites = _favorites;

+ (SGFavorites*) sharedInstance
{
    static SGFavorites *instance;
    
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^
                  {
                      if([[NSFileManager defaultManager] fileExistsAtPath:[SGFavorites filePathName]])
                      {
                          instance = [NSKeyedUnarchiver unarchiveObjectWithFile:[SGFavorites filePathName]];
                      }
                      else
                      {
                          instance = [[SGFavorites alloc] init];
                      }
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

- (void) resetFavorites
{
    [_favorites removeAllObjects];
    [self saveFavorites];
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


+ (NSString*) filePathName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:@"favorites.dat"];
}

- (void) addBlogEntry:(SGBlogEntry *)inEntry
{
    [_favorites addObject:inEntry];
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

@end
