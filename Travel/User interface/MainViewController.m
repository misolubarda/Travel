//
//  MainViewController.m
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "MainViewController.h"
#import "VehicleSelector.h"
#import "MainTableViewDelegate.h"
#import "Travel-Swift.h"

@interface MainViewController () <VehicleSelectorDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet VehicleSelector *vehicleSelector;

@property (strong, nonatomic) MainTableViewDelegate *tableViewDelegate;

@property (strong, nonatomic) id request;

@end

@implementation MainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableViewDelegate = [[MainTableViewDelegate alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.vehicleSelector selectButton:VehicleSelectorButtonType_Train];
    [self vehicleSelected:VehicleSelectorButtonType_Train];
}

#pragma mark - VehicleSelectorDelegate

- (void)vehicleSelected:(VehicleSelectorButtonType)type {
    
    switch (type) {
        case VehicleSelectorButtonType_Train:
        {
            TrainsAPIRequest *request = [[TrainsAPIRequest alloc] initWithBaseURL:<#(NSURL * _Nonnull)#> responseQueue:<#(dispatch_queue_t _Nonnull)#>]
            break;
        }
        default:
            break;
    }
    
}

@end
