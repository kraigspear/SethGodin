//
// Created by Kraig Spear on 3/24/15.
// Copyright (c) 2015 Sportsman Tracker. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STBaseOperation : NSOperation

- (void) setExecuting:(BOOL) toValue;

- (void)setFinished:(BOOL)toValue;

@property (nonatomic, strong) NSError *error;

- (void) done;

@end