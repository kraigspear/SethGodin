//
//  SGArchiveSelection.h
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 The different types of feed selection
 */
typedef enum _feedType
{
    /**
     Select the current feed
     */
    kCurrent,
    /**
     Selects an archive
     */
    kArchive,
    /**
     Selects favorites
     */
    kFavorites,
    /**
     Search results
     */
    kSearch
} kfeedType;

@interface SGFeedSelection : NSObject

- (id) initWithType:(kfeedType) inType;
- (id) initAsArchiveForMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear;

+ (SGFeedSelection*) selectionForMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear;
+ (SGFeedSelection*) selectionAsCurrent;
+ (SGFeedSelection*) selectionAsFavorites;
+ (SGFeedSelection*) selectionAsSearch:(NSString*) inSearchText;

@property (nonatomic, assign) kfeedType feedType;
@property (nonatomic, assign) NSUInteger month;
@property (nonatomic, assign) NSUInteger year;
@property (nonatomic, strong) NSString  *searchText;


@end
