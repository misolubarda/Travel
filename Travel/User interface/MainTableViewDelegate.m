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

@end

@implementation MainTableViewDelegate

static NSString *reuseIdentifier = @"reuseIdentifier";

- (void)setupWithTrips:(NSArray *)trips ofClass:(Class)tripClass {
    self.trips = trips;
    self.tripClass = tripClass;
}

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
        
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:trip.departureTime toDate:trip.arrivalTime options:NSCalendarMatchFirst];
        NSString *duration = [NSString stringWithFormat:@"Duration: %@:%@h", @(components.hour), @(components.minute)];
        cell.durationLabel.text = duration;
        
        cell.priceLabel.text = [NSString stringWithFormat:@"€%.2f", trip.priceInEuro];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trips.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117;
}

@end
