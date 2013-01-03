//
//  Favorite.h
//  SethGodin
//
//  Created by Kraig Spear on 1/3/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Favorite : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * favoriteID;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;

@end
