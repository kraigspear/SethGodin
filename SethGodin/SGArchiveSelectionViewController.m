//
//  SGArvhiveSelectionViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 11/15/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import "SGArchiveSelectionViewController.h"
#import "UIImage+General.h"
#import "NSDate+General.h"
#import "SGNotifications.h"

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
	self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage titleBarWithTitle:@"ARCHIVES"]];
    [self.backButton setImage:[UIImage backButton] forState:UIControlStateNormal];
    [self.leftArrowYearButton setImage:[UIImage leftArrow] forState:UIControlStateNormal];
    [self.rightArrowYearButton setImage:[UIImage rightArrow] forState:UIControlStateNormal];
    
    
    [self.leftArrowMonthButton setImage:[UIImage leftArrow] forState:UIControlStateNormal];
    [self.rightArrowMonthButton setImage:[UIImage rightArrow] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    //Add one to month. Months are 1 based.
    SGFeedSelection *feedSelection = [SGFeedSelection selectionForMonth:self.month + 1 andYear:self.year];
    [[SGNotifications sharedInstance] postFeedSelection:feedSelection];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
