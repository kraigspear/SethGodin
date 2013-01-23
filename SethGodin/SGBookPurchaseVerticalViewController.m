//
//  SGBookPurchaseVerticalViewController.m
//  SethGodin
//
//  Created by Kraig Spear on 1/23/13.
//  Copyright (c) 2013 AndersonSpear. All rights reserved.
//

#import "SGBookPurchaseVerticalViewController.h"
#import "SGPurchaseItemGetter.h"

@interface SGBookPurchaseVerticalViewController ()

@end

@implementation SGBookPurchaseVerticalViewController
{
@private
    SGPurchaseItemGetter   *_purchaseItemGetter;
    NSArray                *_items;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_purchaseItemGetter = [[SGPurchaseItemGetter alloc] init];
    
    [_purchaseItemGetter latestItems:^(NSArray *latestItems)
     {
         _items = latestItems;
         [self.collectionView reloadData];
     } failed:^(NSError *error)
     {
         
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 148);
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}


#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
//    HourForecastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCell" forIndexPath:indexPath];
//    
//    
//    cell.isDay = [_hourlyForcast isDayForHour:indexPath.row];
//    
//    NSString *conditionImageName = [_hourlyForcast imageNameForHour:indexPath.row];
//    
//    cell.conditionImageView.image = [UIImage imageNamed:conditionImageName];
//    cell.timeLabel.text = [_timeFormatter stringFromDate:[_hourlyForcast dateForHour:indexPath.row]];
//    
//    NSInteger precip = [_hourlyForcast precipAmoutForHour:indexPath.row];
//    cell.precipLabel.text = [NSString stringWithFormat:@"%d%%", precip];
//    cell.windDirectionLabel.text = [self windStringForRow:indexPath.row];
//    cell.tempLabel.text = [NSString temperatureStringFor:[_hourlyForcast temperatureForHour:indexPath.row]];
    
   // return cell;
    
}



@end
