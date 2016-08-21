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

@end

@implementation MainViewController

#pragma mark - Setters/Getters
- (MainTableViewDelegate *)tableViewDelegate {
    if (!_tableViewDelegate) {
        _tableViewDelegate = [[MainTableViewDelegate alloc] init];
    }
    return _tableViewDelegate;
}

#pragma mark - View setup

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.tableViewDelegate;
    [self.vehicleSelector selectButton:VehicleSelectorButtonType_Train];
    [self vehicleSelected:VehicleSelectorButtonType_Train];
}

#pragma mark - IBActions

- (IBAction)sortButtonTapped:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sort by:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *arrival = [UIAlertAction actionWithTitle:@"Arrival" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.tableViewDelegate sortBy:TripSortingType_Arrival];
        [self.tableView reloadData];
    }];
    UIAlertAction *departure = [UIAlertAction actionWithTitle:@"Departure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.tableViewDelegate sortBy:TripSortingType_Departure];
        [self.tableView reloadData];
    }];
    UIAlertAction *duration = [UIAlertAction actionWithTitle:@"Duration" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.tableViewDelegate sortBy:TripSortingType_Duration];
        [self.tableView reloadData];
    }];
    [alertController addAction:arrival];
    [alertController addAction:departure];
    [alertController addAction:duration];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - VehicleSelectorDelegate

- (void)vehicleSelected:(VehicleSelectorButtonType)type {
    
    switch (type) {
        case VehicleSelectorButtonType_Train:
        {
            [TripManager fetchTrainTripsWithCompletion:^(NSArray<TrainTrip *> * _Nullable response) {
                [self reloadTableWithTrips:response ofClass:[TrainTrip class]];
            }];
            break;
        }
        case VehicleSelectorButtonType_Bus:
        {
            [TripManager fetchBusTripsWithCompletion:^(NSArray<BusTrip *> * _Nullable response) {
                [self reloadTableWithTrips:response ofClass:[BusTrip class]];
            }];
            break;
        }
        case VehicleSelectorButtonType_Flight:
        {
            [TripManager fetchFlightTripsWithCompletion:^(NSArray<FlightTrip *> * _Nullable response) {
                [self reloadTableWithTrips:response ofClass:[FlightTrip class]];
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Helpers

- (void)reloadTableWithTrips:(NSArray *)trips ofClass:(Class)tripClass {
    [self.tableViewDelegate setupWithTrips:trips ofClass:tripClass];
    [self.tableView reloadData];
    if (trips.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

@end
