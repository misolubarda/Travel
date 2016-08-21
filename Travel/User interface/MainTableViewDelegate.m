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
    
    if (self.tripClass == [TrainTrip class] || self.tripClass == [BusTrip class] || self.tripClass == [FlightTrip class]) {
        //TODO: configure cell
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
