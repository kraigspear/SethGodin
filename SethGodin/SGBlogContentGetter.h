//
//  SGBlogContentGetter.h
//  SethGodin
//
//  Created by Kraig Spear on 11/10/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BlogContentSuccess)(NSArray*);
typedef void (^BlogContentFailed)(NSError*);

@interface SGBlogContentGetter : NSObject

- (void) requestLatestBlocksuccess:(BlogContentSuccess) inSuccess failed:(BlogContentFailed) inError;

@end
