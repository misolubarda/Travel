//
//  MainTableViewDelegate.m
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

@import UIKit;

#import "MainTableViewDelegate.h"
#import "MainCell.h"
#import "Travel-Swift.h"

@interface MainTableViewDelegate ()

@property (nonatomic, strong) NSArray *trips;
@property (nonatomic) Class tripClass;
@property (nonatomic) TripSortingType lastSortingType;

@end

@implementation MainTableViewDelegate

static NSString *reuseIdentifier = @"reuseIdentifier";

#pragma mark - Setup
- (void)setupWithTrips:(NSArray *)trips ofClass:(Class)tripClass {
    self.trips = trips;
    self.tripClass = tripClass;
    [self sortBy:self.lastSortingType];
}

#pragma mark - Sort

- (void)sortBy:(TripSortingType)sortingType {
    self.lastSortingType = sortingType;
    self.trips = [self.trips sortedArrayUsingComparator:^NSComparisonResult(TrainTrip * _Nonnull trip1, TrainTrip * _Nonnull trip2) {
        switch (sortingType) {
            case TripSortingType_Arrival:
                return [trip1.arrivalTime compare:trip2.arrivalTime];
            case TripSortingType_Departure:
                return [trip1.departureTime compare:trip2.departureTime];
            case TripSortingType_Duration:
                return [trip1.duration compare:trip2.duration];
        }
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // In this example all trips (TrainTrip, FlightTrip, BusTrip) has the same structure.
    TrainTrip *trip = self.trips[indexPath.row];
    
    if (self.tripClass == [TrainTrip class] || self.tripClass == [BusTrip class] || self.tripClass == [FlightTrip class]) {
        
        // This is very bad practice. Would need to implement image caching (or use existing Alamofire) and loading them in model. No time left to do that.
        cell.logoImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:trip.providerLogo]];
        
        NSString *departureTime = [[Helper dateFormatter] stringFromDate:trip.departureTime];
        NSString *arrivalTime = [[Helper dateFormatter] stringFromDate:trip.arrivalTime];
        NSString *tripTimeString = [NSString stringWithFormat:@"%@ - %@", departureTime, arrivalTime];
        cell.timeLabel.text = tripTimeString;
        
        NSDate *duration = [trip duration];
        NSString *durationString = [NSString stringWithFormat:@"Duration: %@", [[Helper dateFormatter] stringFromDate:duration]];
        cell.durationLabel.text = durationString;
        
        cell.priceLabel.text = [NSString stringWithFormat:@"€%.2f", trip.priceInEuro];
        
        cell.stopsLabel.text = [NSString stringWithFormat:@"Stops: %@", @(trip.stops)];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trips.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Offer details are not yet implemented!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
