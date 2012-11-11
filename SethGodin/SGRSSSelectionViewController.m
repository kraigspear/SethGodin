//
//  SGViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/9/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGRSSSelectionViewController.h"
#import "UIImage+RSSSelection.h"
#import "SGBlogContentGetter.h"
#import "SGBlogEntry.h"

@interface SGRSSSelectionViewController ()

@end

@implementation SGRSSSelectionViewController
{
@private
    NSDateFormatter *_dateFormatter;
    NSArray *_blogItems;
    SGBlogContentGetter *_contentGetter;
    NSUInteger _pageNumber;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _contentGetter = [[SGBlogContentGetter alloc] init];
    
	[self.upButton setImage:[UIImage upButton] forState:UIControlStateNormal];
    [self.downButton setImage:[UIImage downButton] forState:UIControlStateNormal];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBar]];
    
    [self.searchButton setImage:[UIImage searchButton] forState:UIControlStateNormal];
    [self.menuButton setImage:[UIImage menuButton] forState:UIControlStateNormal];
    
    _dateFormatter           = [[NSDateFormatter alloc] init];
    _dateFormatter.dateStyle =  NSDateFormatterMediumStyle;
    
    _pageNumber = 0;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_contentGetter requestLatestBlocksuccess:^(NSArray *inItems)
    {
        _blogItems = inItems;
        [self updateButtons];
    } failed:^(NSError *inError)
    {
        
    }];
}

- (void) updateButtons
{
    NSUInteger startAt = _pageNumber * 3;
    
    SGBlogEntry *entry1 = [_blogItems objectAtIndex:startAt];
    SGBlogEntry *entry2 = [_blogItems objectAtIndex:startAt+1];
    SGBlogEntry *entry3 = [_blogItems objectAtIndex:startAt+2];
    
    UIColor* buttonColor = [UIColor colorWithRed: 0.751 green: 0.703 blue: 0.608 alpha: 1];
    
    UIImage *button1Image = [UIImage rssItemButtonForColor:buttonColor
                                                   andSize:self.rssItem1Button.frame.size
                                                     title:entry1.displayName
                                                    shared:1000
                                                   forDate:entry1.datePublished
                                            formatDateWith:_dateFormatter];
    
    
    [self.rssItem1Button setImage:button1Image forState:UIControlStateNormal];
    
    UIColor* buttonColor2 = [buttonColor colorWithAlphaComponent: 0.8];
    
    UIImage *button2Image = [UIImage rssItemButtonForColor:buttonColor2
                                                   andSize:self.rssItem2Button.frame.size
                                                     title:entry2.displayName
                                                    shared:1000
                                                   forDate:entry2.datePublished
                                            formatDateWith:_dateFormatter];
    
    [self.rssItem2Button setImage:button2Image forState:UIControlStateNormal];
    
    UIColor* buttonColor3 = [buttonColor colorWithAlphaComponent: 0.6];
    
    UIImage *button3Image = [UIImage rssItemButtonForColor:buttonColor3
                                                   andSize:self.rssItem3Button.frame.size
                                                     title:entry3.displayName
                                                    shared:1000
                                                   forDate:entry3.datePublished
                                            formatDateWith:_dateFormatter];
    
    [self.rssItem3Button setImage:button3Image forState:UIControlStateNormal];
    
}


- (IBAction)previousButton:(id)sender
{
    _pageNumber--;
    [self updateButtons];
}

- (IBAction)nextButton:(id)sender
{
    _pageNumber++;
    [self updateButtons];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
