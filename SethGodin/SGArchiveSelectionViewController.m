//
//  SGArvhiveSelectionViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/15/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGArchiveSelectionViewController.h"
#import "SGUpdradeViewController.h"
#import "UIImage+General.h"
#import "NSDate+General.h"
#import "SGNotifications.h"
#import "SGUSerDefaults.h"
#import "SGLogger.h"
#import "Flurry.h"
#import "SGMainViewController.h"
#import "SGAskToPurchaseViewController.h"
#import "UIColor+General.h"

@interface SGArchiveSelectionViewController ()

@end

@implementation SGArchiveSelectionViewController
{
@private
    NSUInteger _currentYear;
    NSUInteger _currentMonth;
    NSDateFormatter *_dateFormatter;
}

const NSUInteger MIN_YEAR = 2002;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    
    _currentYear  = [[NSDate date] year];
    self.month = [[NSDate date] month] - 1;
    
    self.year = _currentYear;
    [self.leftArrowYearButton setImage:[UIImage leftArrow] forState:UIControlStateNormal];
    [self.rightArrowYearButton setImage:[UIImage rightArrow] forState:UIControlStateNormal];
    
    
    [self.leftArrowMonthButton setImage:[UIImage leftArrow] forState:UIControlStateNormal];
    [self.rightArrowMonthButton setImage:[UIImage rightArrow] forState:UIControlStateNormal];
    
    [self.view removeConstraint:self.goButtonHeightConstraint];
    
    self.goButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.goButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:.4 constant:0];
    
    [self.view addConstraint:self.goButtonHeightConstraint];
    
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if(IS_IPHONE5)
    {
        self.leftArrowYearToTopConstraint.constant = 43;
        self.leftArrowMonthToBottomConstraint.constant = 63;
    }
    else
    {
       // self.leftArrowYearToTopConstraint.constant = 15;
       // self.leftArrowMonthToBottomConstraint.constant = 13;
    }
    
    [self.view layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)yearBackAction:(id)sender
{
    NSUInteger previousYear = self.year - 1;
    
    if(previousYear < MIN_YEAR)
    {
        previousYear = [[NSDate date] year];
    }
    
    self.year = previousYear;
}

- (IBAction)yearForwardButton:(id)sender
{
    NSUInteger nextYear = self.year + 1;
    
    if(nextYear > _currentYear)
    {
        nextYear = MIN_YEAR;
    }

    self.year = nextYear;
}

- (void) setYear:(NSUInteger)year
{
    _year = year;
    self.yearLabel.text = [NSString stringWithFormat:@"%d", self.year];
}

- (void) setMonth:(NSUInteger)month
{
    _month = month;
    self.monthLabel.text = [[_dateFormatter monthSymbols] objectAtIndex:self.month];
}

- (IBAction)monthBackAction:(id)sender
{
    NSInteger previousMonth = self.month - 1;
    if(previousMonth < 0)
    {
        previousMonth = 11;
    }
    self.month = previousMonth;
}

- (IBAction)monthForwaredAction:(id)sender
{
    NSUInteger nextMonth = self.month + 1;
    
    if(nextMonth >= 12)
    {
        nextMonth = 0;
    }
    
    self.month = nextMonth;
}



- (IBAction)goAction:(id)sender
{
    if([SGUserDefaults sharedInstance].isUpgraded)
    {
        [self selectFeed];
    }
    else
    {
        [self askToPurchase:sender];
    }
}

- (void) selectFeed
{
    //Add one to month. Months are 1 based.
    SGFeedSelection *feedSelection = [SGFeedSelection selectionForMonth:self.month + 1 andYear:self.year];
    [SGNotifications postFeedSelection:feedSelection];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) askToPurchase:(id) sender
{
    [[SGLogger sharedInstance] logAskToPurchaseFrom:@"Archive"];
    
    if(IS_IPAD)
    {
        [self askToPurchaseOniPad:sender];
    }
    else
    {
        SGUpdradeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"askToUpgradd"];
        vc.popbackViewController = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void) askToPurchaseOniPad:(id) sender
{
    SGAskToPurchaseViewController *askToPurchaseViewController = [[SGAskToPurchaseViewController alloc] init];
    
    askToPurchaseViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    
   [[SGMainViewController sharedInstance] presentViewController:askToPurchaseViewController animated:YES completion:^
    {
        
    }];
    
    
}

#pragma mark -
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"ARCHIVES";
}

- (UIImage*) leftButtonImage
{
    return [UIImage backButtonWithColor:[UIColor menuTitleBarTextColor]];
}

- (void) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
