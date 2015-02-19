//
//  Bookmark.h
//  SethGodin
//
//  Created by Kraig Spear on 2/18/15.
//  Copyright (c) 2015 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bookmark : NSManagedObject

@property (nonatomic, retain) NSString * idStr;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * datePublished;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * url;

@end
