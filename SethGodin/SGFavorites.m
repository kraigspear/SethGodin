//
//  SGFavorites.m
//  SethGodin
//
//  Created by Kraig Spear on 11/13/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFavorites.h"

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


- (void) saveFavorites
{
    [NSKeyedArchiver archiveRootObject:self toFile:[SGFavorites filePathName]];
}

+ (SGFavorites*) loadFavorites
{
    NSString *fileNamePath = [SGFavorites filePathName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:fileNamePath])
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
