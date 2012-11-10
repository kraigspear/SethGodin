//
//  SGViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGRSSSelectionViewController.h"
#import "UIImage+RSSSelection.h"

@interface SGRSSSelectionViewController ()

@end

@implementation SGRSSSelectionViewController
{
@private
    NSDateFormatter *_dateFormatter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.upButton setImage:[UIImage upButton] forState:UIControlStateNormal];
    [self.downButton setImage:[UIImage downButton] forState:UIControlStateNormal];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBar]];
    
    [self.searchButton setImage:[UIImage searchButton] forState:UIControlStateNormal];
    [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
    
    _dateFormatter           = [[NSDateFormatter alloc] init];
    _dateFormatter.dateStyle =  NSDateFormatterMediumStyle;
    
    
    
    
}


- (void) viewDidLayoutSubviews
{
    UIColor* buttonColor = [UIColor colorWithRed: 0.751 green: 0.703 blue: 0.608 alpha: 1];
    
    if(self.rssItem1Button.frame.size.width > 0 && self.rssItem1Button.frame.size.height > 0)
    {
        
        
        UIImage *button1Image = [UIImage rssItemButtonForColor:buttonColor
                                                       andSize:self.rssItem1Button.frame.size
                                                         title:@"button1"
                                                        shared:1000
                                                       forDate:[NSDate date]
                                                formatDateWith:_dateFormatter];
        
        [self.rssItem1Button setImage:button1Image forState:UIControlStateNormal];
    }
    
    if(self.rssItem2Button.frame.size.width > 0 && self.rssItem2Button.frame.size.height > 0)
    {
        UIColor* buttonColor2 = [buttonColor colorWithAlphaComponent: 0.8];
        
        UIImage *button1Image = [UIImage rssItemButtonForColor:buttonColor2
                                                       andSize:self.rssItem2Button.frame.size
                                                         title:@"button2"
                                                        shared:1000
                                                       forDate:[NSDate date]
                                                formatDateWith:_dateFormatter];
        
        [self.rssItem2Button setImage:button1Image forState:UIControlStateNormal];
    }
    
    if(self.rssItem3Button.frame.size.width > 0 && self.rssItem3Button.frame.size.height > 0)
    {
        UIColor* buttonColor3 = [buttonColor colorWithAlphaComponent: 0.6];
        
        UIImage *button1Image = [UIImage rssItemButtonForColor:buttonColor3
                                                       andSize:self.rssItem3Button.frame.size
                                                         title:@"button3"
                                                        shared:1000
                                                       forDate:[NSDate date]
                                                formatDateWith:_dateFormatter];
        
        [self.rssItem3Button setImage:button1Image forState:UIControlStateNormal];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
