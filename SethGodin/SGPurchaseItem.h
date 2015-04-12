//
//  SGPurchaseItem.h
//  SethGodin
//
//  Created by Kraig Spear on 11/18/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bolts.h"

/**
 An item that can be purchased on iTunes.
 */
@interface SGPurchaseItem : NSObject 


/**
 The date this title was released
 */
@property (nonatomic, readonly) NSDate     *releasedDate;

/**
 The book title
 */
@property (nonatomic, readonly) NSString   *title;

/**
 The trackID. This is the iTunes ID that is used to tell iTunes what item to bring up.
 */
@property (nonatomic, readonly) NSUInteger trackID;

/**
 The image of the book.
 */
@property (nonatomic, strong, readwrite) UIImage *image;


/**
 Initialize the purchase item with readonly data members
 @param inTitle  The title of the book
 @param inDate The date the item was released
 @param trackId The iTunes ID
 */
- (instancetype) initWithTitle:(NSString*) inTitle releasedOn:(NSDate*) inDate
                       trackId:(NSUInteger) inTrackId;


@end
