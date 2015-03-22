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
#import "UIColor+General.h"
#import "SGFavoritesParse.h"

@interface SGArchiveSelectionViewController ()

@end

@implementation SGArchiveSelectionViewController
{
@private
    NSUInteger _currentYear;
    NSDateFormatter *_dateFormatter;
}

const NSUInteger MIN_YEAR = 2002;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.screenName = @"Archives";
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
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

}
#pragma clang diagnostic pop


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
    self.yearLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.year];
}

- (void) setMonth:(NSUInteger)month
{
    _month = month;
    self.monthLabel.text = [_dateFormatter monthSymbols][self.month];
}

- (IBAction)monthBackAction:(id)sender
{
    NSInteger previousMonth = self.month - 1;
    if(previousMonth < 0)
    {
        previousMonth = 11;
    }
    self.month = (NSUInteger) previousMonth;
}

- (IBAction)monthForwardAction:(id)sender
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
    [self selectFeed];
}

- (void) selectFeed
{
    //Add one to month. Months are 1 based.
    SGFeedSelection *feedSelection = [SGFeedSelection selectionForMonth:self.month + 1 andYear:self.year];
    
    [SGFavoritesParse updateUserLastArchiveSearchForMonth:self.month year:self.year];
    
    [SGNotifications postFeedSelection:feedSelection];
    
    NSLog(@"navController = %@", self.navigationController);
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark SGTitleViewDelegate

- (NSString*) titleText
{
    return @"ARCHIVES";
}

- (UIImage*) leftButtonImage
{
    if(IS_IPHONE)
    {
        return [UIImage backButtonWithColor:[UIColor menuTitleBarTextColor]];
    }
    else
    {
        return nil;
    }
}

- (void) leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIColor*) titleViewBackgroundColor
{
    if(IS_IPHONE)
    {
        return [UIColor menuTitleBarBackgroundColor];
    }
    else
    {
        return [UIColor titlebarBackgroundColor];
    }
}

- (UIColor*) titleTextColor
{
    if(IS_IPHONE)
    {
        return [UIColor menuTitleBarTextColor];
    }
    else
    {
        return [UIColor titlebarTextColor];
    }
}


@end
