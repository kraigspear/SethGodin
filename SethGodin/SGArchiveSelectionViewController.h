//
//  SGArvhiveSelectionViewController.h
//  SethGodin
//
//  Created by Kraig Spear on 11/15/12.
//  Copyright (c) 2012 AndersonSpear. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlockTypes.h"

@interface SGArchiveSelectionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowYearButton;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowYearButton;

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (nonatomic, assign) NSUInteger year;
@property (nonatomic, assign) NSUInteger month;

@property (weak, nonatomic) IBOutlet UILabel *leftArrowMonth;

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UIButton *leftArrowMonthButton;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowMonthButton;

@end
