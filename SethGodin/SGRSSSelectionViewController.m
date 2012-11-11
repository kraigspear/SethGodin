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
    
    SGBlogEntry *_entry1;
    SGBlogEntry *_entry2;
    SGBlogEntry *_entry3;
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
    
    [_entry1 removeObserver:self forKeyPath:@"shareCount"];
    [_entry2 removeObserver:self forKeyPath:@"shareCount"];
    [_entry3 removeObserver:self forKeyPath:@"shareCount"];
    
    _entry1 = [_blogItems objectAtIndex:startAt];
    _entry2 = [_blogItems objectAtIndex:startAt+1];
    _entry3 = [_blogItems objectAtIndex:startAt+2];
    
    [_entry1 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    [_entry2 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    [_entry3 addObserver:self forKeyPath:@"shareCount" options:NSKeyValueObservingOptionNew context:nil];
    
    [self updateButtonForEntry:_entry1];
    [self updateButtonForEntry:_entry2];
    [self updateButtonForEntry:_entry3];
    
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"shareCount"])
    {
        [self updateButtonForEntry:object];
    }
}

- (void) updateButtonForEntry:(SGBlogEntry*) inEntry
{
    UIColor* buttonColor = [UIColor colorWithRed: 0.751 green: 0.703 blue: 0.608 alpha: 1];
    if(inEntry == _entry1)
    {
        [self updateButtonImage:inEntry forButton:_rssItem1Button withColor:buttonColor];
    }
    else if(inEntry == _entry2)
    {
        UIColor* buttonColor2 = [buttonColor colorWithAlphaComponent: 0.8];
        [self updateButtonImage:inEntry forButton:_rssItem2Button withColor:buttonColor2];
    }
    else if(inEntry == _entry3)
    {
        UIColor* buttonColor3 = [buttonColor colorWithAlphaComponent: 0.6];
        [self updateButtonImage:inEntry forButton:_rssItem3Button withColor:buttonColor3];
    }

}

- (void) updateButtonImage:(SGBlogEntry*) inEntry forButton:(UIButton*) inButton withColor:(UIColor*) inColor
{
    UIImage *buttonImage = [UIImage rssItemButtonForColor:inColor
                                                   andSize:inButton.frame.size
                                                     title:inEntry.displayName
                                                    shared:inEntry.shareCount
                                                   forDate:inEntry.datePublished
                                            formatDateWith:_dateFormatter];
    
    [inButton setImage:buttonImage forState:UIControlStateNormal];
    
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
