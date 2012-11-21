//
//  BlockTypes.h
//  SethGodin
//
//  Created by Kraig Spear on 11/12/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#ifndef SethGodin_BlockTypes_h
#define SethGodin_BlockTypes_h


typedef void (^BasicBlock) (void);
typedef void (^BoolBlock)  (BOOL);
typedef void (^ArrayBlock)(NSArray*);
typedef void (^ErrorBlock)(NSError*);
typedef void (^StringBlock) (NSString*);


#endif
