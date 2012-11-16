//
//  SGArchiveSelection.h
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum _feedType
{
    kCurrent,
    kArchive,
    kFavorites
} kfeedType;

@interface SGFeedSelection : NSObject

- (id) initWithType:(kfeedType) inType;
- (id) initAsArchiveForMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear;

+ (SGFeedSelection*) selectionForMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear;
+ (SGFeedSelection*) selectionAsCurrent;
+ (SGFeedSelection*) selectionAsFavorites;

@property (nonatomic, assign) kfeedType feedType;
@property (nonatomic, assign) NSUInteger month;
@property (nonatomic, assign) NSUInteger year;

@end
