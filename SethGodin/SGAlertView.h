//
//  SGAlertView.h
//  SethGodin
//
//  Created by Kraig Spear on 11/29/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockTypes.h"


@interface SGAlertView : NSObject <UIAlertViewDelegate>

- (void) showError:(NSError*) inError done:(SWBasicBlock) inDone;

@end
