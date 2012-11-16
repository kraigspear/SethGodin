//
//  SGArchiveContentGetter.h
//  SethGodin
//
//  Created by Kraig Spear on 11/16/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGConentGetter.h"

@interface SGArchiveContentGetter : SGConentGetter

- (id) initWithMonth:(NSUInteger) inMonth andYear:(NSUInteger) inYear;

@end
