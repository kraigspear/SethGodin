//
//  SGConentGetter.h
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BlogContentSuccess)(NSArray*);
typedef void (^BlogContentFailed)(NSError*);

@interface SGConentGetter : NSObject

- (void) requestLatestBlocksuccess:(BlogContentSuccess) inSuccess failed:(BlogContentFailed) inError;


- (NSDate*) dateFromString:(NSString*) inDateStr;


@end
