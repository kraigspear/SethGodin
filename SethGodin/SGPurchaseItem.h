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
@interface SGPurchaseItem : NSObject <NSCoding>

/**
 The artist ID from iTunes.
 That can be Author, Band. Basically the content creator.
 */
@property (nonatomic, readonly) NSUInteger artistId;

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
 The URL of the image from Apple.
 */
@property (nonatomic, readonly) NSString *imageURL;

/**
 The image of the book.
 */
@property (nonatomic, strong) UIImage *image;

/**
 Purchase this item
 */
- (void) purchase;

- (BFTask*) loadImage;

/**
 Initilize the purchase item with readonly data members
 @param inTitle  The title of the book
 @param inArtist The artist
 @param inDate The date the item was released
 @param trackId The iTunes ID
 */
- (id) initWithTitle:(NSString*) inTitle artest:(NSUInteger) inArtist releasedOn:(NSDate*) inDate
             trackId:(NSUInteger) inTrackId
             imageURL:(NSString*) inImageURL;

@end
