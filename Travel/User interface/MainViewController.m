//
//  MainViewController.m
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "MainViewController.h"
#import "VehicleSelector.h"

@interface MainViewController () <VehicleSelectorDelegate>

@property (weak, nonatomic) IBOutlet VehicleSelector *vehicleSelector;

@end

@implementation MainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.vehicleSelector.delegate = self;
}

#pragma mark - VehicleSelectorDelegate

- (void)vehicleSelected:(VehicleSelectorButtonType)type {
    
}

@end
