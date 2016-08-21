//
//  MainTableViewDelegate.h
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TripSortingType) {
    TripSortingType_Arrival,
    TripSortingType_Departure,
    TripSortingType_Duration
};

@interface MainTableViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void)setupWithTrips:(NSArray *)trips ofClass:(Class)tripClass;
- (void)sortBy:(TripSortingType)sortingType;

@end
