//
//  SGFavorites.m
//  SethGodin
//
//  Created by Kraig Spear on 11/13/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavorites.h"
#import "SGFavoritesDocument.h"

@implementation SGFavorites
{
@private
    NSMutableArray *_favorites;
}

NSString * const KEY_FAVORITES = @"favorites";

@synthesize favorites = _favorites;


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

+ (BOOL) favoritesFileExist
{
    NSString *fileNamePath = [SGFavorites filePathName];
    return [[NSFileManager defaultManager] fileExistsAtPath:fileNamePath];
}

+ (SGFavorites*) loadFavoritesNotUsingUIDocument
{
    NSString *fileNamePath = [SGFavorites filePathName];
    
    if([SGFavorites favoritesFileExist])
    {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:fileNamePath];
    }
    else
    {
        return [[SGFavorites alloc] init];
    }
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
}

- (void) removeBlogEntry:(SGBlogEntry*) inEntry
{
    [_favorites removeObject:inEntry];
}

- (BOOL) containsBlogEntry:(SGBlogEntry*) inEntry
{
    return [_favorites containsObject:inEntry];
}

 

@end
