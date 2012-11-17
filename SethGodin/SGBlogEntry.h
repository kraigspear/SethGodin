//
//  SGBlogEntry.h
//  SethGodin
//
//  Created by Kraig Spear on 11/10/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Data of a blog entry.
 */
@interface SGBlogEntry : NSObject <NSCoding>

/**
 The blog tile.
 */
@property (nonatomic, readonly) NSString *title;

/**
 The date the blog entry was published
 */
@property (nonatomic, readonly) NSDate   *datePublished;

/**
 Summary (or excerpt) of the blog
 */
@property (nonatomic, readonly) NSString *summary;

/**
 The content of the blog. The entire blog posted formatted as HTML
 */
@property (nonatomic, readonly) NSString *content;

/**
 The item ID. The unique identifer for this entry.
 */
@property (nonatomic, readonly) NSString *itemID;

/**
 URL where the blog post can be found on the Internet.
 */
@property (nonatomic, readonly) NSString *urlStr;

/**
 How many times this entry has been shared.
 */
@property (nonatomic, assign)   NSUInteger shareCount;


/**
 Required initilizer for this class. Most of the data is readonly, and is set here.
 @param inTitle setter for title
 @param inDate  setter for date
 @param inSummary setter for the summary
 @param inContent setter for the content
 @param inID setter for the ID
 @param inURLStr setter for the url string.
 */
- (id) initWithTitle:(NSString*) inDisplayName
                publishedOn:(NSDate*) inDate
                summary:(NSString*) inSummary
                   content:(NSString*) inContent
                   itemID:(NSString*) inID
                   fromURL:(NSString*) inUrlStr;





@end
