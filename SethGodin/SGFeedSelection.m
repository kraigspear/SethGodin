//
//  SGArchiveSelection.m
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGFeedSelection.h"

@implementation SGFeedSelection

- (id) initWithType:(kfeedType) inType
{
    self = [self init];

    if(self)
    {
        self.feedType = inType;
    }
    
    return self;
}

- (id) initAsArchiveForMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear
{
    self = [self init];
    
    if(self)
    {
        self.feedType = kArchive;
        self.month = inMonth;
        self.year  = inYear;
    }
    
    return self;
}

- (id) initWithSearchText:(NSString*) inSearchText
{
    self = [self init];

    self.feedType = kSearch;
    self.searchText = inSearchText;    
    
    return self;
}

+ (SGFeedSelection*) selectionAsSearch:(NSString*) inSearchText
{
    return [[SGFeedSelection alloc] initWithSearchText:inSearchText];
}

+ (SGFeedSelection*) selectionForMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear
{
    return [[SGFeedSelection alloc] initAsArchiveForMonth:inMonth andYear:inYear];
}

+ (SGFeedSelection*) selectionAsCurrent
{
    return [[SGFeedSelection alloc] initWithType:kCurrent];
}

+ (SGFeedSelection*) selectionAsFavorites
{
    return [[SGFeedSelection alloc] initWithType:kFavorites];
}



@end
