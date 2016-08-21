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

- (MainTableViewDelegate *)tableViewDelegate {
    if (!_tableViewDelegate) {
        _tableViewDelegate = [[MainTableViewDelegate alloc] init];
    }
    return _tableViewDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.tableViewDelegate;
    [self.vehicleSelector selectButton:VehicleSelectorButtonType_Train];
    [self vehicleSelected:VehicleSelectorButtonType_Train];
}

#pragma mark - VehicleSelectorDelegate

- (void)vehicleSelected:(VehicleSelectorButtonType)type {
    
    switch (type) {
        case VehicleSelectorButtonType_Train:
        {
            [TripManager fetchTrainTripsWithCompletion:^(NSArray<TrainTrip *> * _Nullable response) {
                [self.tableViewDelegate setupWithTrips:response ofClass:[TrainTrip class]];
                [self.tableView reloadData];
            }];
            break;
        }
        default:
            break;
    }
    
}

@end
