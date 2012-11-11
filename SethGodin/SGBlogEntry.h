//
//  SGBlogEntry.h
//  SethGodin
//
//  Created by Kraig Spear on 11/10/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGBlogEntry : NSObject

@property (nonatomic, readonly) NSString *displayName;
@property (nonatomic, readonly) NSDate   *datePublished;
@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, readonly) NSString *content;
@property (nonatomic, readonly) NSString *itemID;
@property (nonatomic, readonly) NSString *urlStr;
@property (nonatomic, assign)   NSUInteger shareCount;

- (id) initWithDisplayName:(NSString*) inDisplayName
                publishedOn:(NSDate*) inDate
                summary:(NSString*) inSummary
                   content:(NSString*) inContent
                   itemID:(NSString*) inID
                   fromURL:(NSString*) inUrlStr;





@end
