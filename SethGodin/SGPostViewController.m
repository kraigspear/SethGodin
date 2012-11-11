//
//  SGPostView.m
//  SethGodin
//
//  Created by Kraig Spear on 11/11/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGPostViewController.h"
#import "UIImage+RSSSelection.h"
#import "UIImage+Buttons.h"
#import "UIImage+BBlock.h"
#import "SGBlogEntry.h"
#import "SGAppDelegate.h"


@implementation SGPostViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBar]];
    [self.backButton setImage:[UIImage backButton] forState:UIControlStateNormal];
    
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewDidLayoutSubviews
{
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[self titleImage]];
    [self.textView setValue: self.blogEntry.content forKey:@"contentToHTMLString"];
}

- (UIImage*) titleImage
{
    //NSString* titleTextContent = self.blogEntry.displayName;
    //NSString* dateTextContent =  [appDelegate.dateformatter stringFromDate:self.blogEntry.datePublished];

    return [UIImage imageForSize:self.titleView.frame.size withDrawingBlock:^
    {
        //// Color Declarations
        UIColor* tan = [UIColor colorWithRed: 0.729 green: 0.718 blue: 0.652 alpha: 1];
        
        SGAppDelegate *appDelegate = (SGAppDelegate*) [[UIApplication sharedApplication] delegate];
        //// Abstracted Attributes
        NSString* titleTextContent = self.blogEntry.displayName;
        NSString* dateTextContent =  [appDelegate.dateformatter stringFromDate:self.blogEntry.datePublished];
        
        
        //// backRect Drawing
        UIBezierPath* backRectPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 132)];
        [tan setFill];
        [backRectPath fill];
        
        
        //// titleText Drawing
        CGRect titleTextRect = CGRectMake(15, 17, 291, 84);
        [[UIColor whiteColor] setFill];
        [titleTextContent drawInRect: titleTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Bold" size: 26] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentLeft];
        
        
        //// dateText Drawing
        CGRect dateTextRect = CGRectMake(17, 97, 222, 35);
        [[UIColor whiteColor] setFill];
        [dateTextContent drawInRect: dateTextRect withFont: [UIFont fontWithName: @"HelveticaNeue-Light" size: 15] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentLeft];
        
        

    }];
}




@end
