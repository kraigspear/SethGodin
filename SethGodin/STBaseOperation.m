//
// Created by Kraig Spear on 3/24/15.
// Copyright (c) 2015 Sportsman Tracker. All rights reserved.
//

#import "STBaseOperation.h"


@implementation STBaseOperation
{
@private
  BOOL _executing;
  BOOL _finished;
}

- (instancetype) init
{
  self = [super init];

  _executing = NO;
  _finished = NO;

  return self;
}

- (BOOL)isExecuting
{
  return _executing;
}

- (void) setExecuting:(BOOL) toValue
{
  [self willChangeValueForKey:@"isExecuting"];
  _executing = toValue;
  [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isFinished
{
   return _finished;
}

- (void) setFinished:(BOOL) toValue
{
  [self willChangeValueForKey:@"isFinished"];
  _finished = toValue;
  [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isAsynchronous
{
  return YES;
}

- (void) done
{
    self.executing = NO;
    self.finished = YES;
}

@end