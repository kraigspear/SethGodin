//
//  SGMenuViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/12/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGMenuViewController.h"
#import "UIImage+General.h"
#import "UIImage+Menu.h"

@implementation SGMenuViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.titleBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBar]];
    [self.closeButton setImage:[UIImage closeButton] forState:UIControlStateNormal];
}

- (void) viewDidLayoutSubviews
{
    self.backgroundImageView.image = [UIImage backgroundImageForSize:self.backgroundImageView.frame.size];
}

- (IBAction)closeAction:(id)sender
{
    self.close();
}


@end
