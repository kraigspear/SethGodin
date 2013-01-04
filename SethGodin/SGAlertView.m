//
//  SGAlertView.m
//  SethGodin
//
//  Created by Kraig Spear on 11/29/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGAlertView.h"


@implementation SGAlertView
{
@private
    SWBasicBlock _doneBlock;
    UIAlertView *_alertView;
}

- (void) showError:(NSError*) inError done:(SWBasicBlock) inDone
{
    _doneBlock = [inDone copy];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:inError.description delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"", nil];
    
    alertView.delegate = self;
    
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(_doneBlock) _doneBlock();
    _doneBlock = nil;
    _alertView = nil;
}

@end
