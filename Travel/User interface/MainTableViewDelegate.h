//
//  MainTableViewDelegate.h
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainTableViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void)setupWithTrips:(NSArray *)trips ofClass:(Class)tripClass;

@end
