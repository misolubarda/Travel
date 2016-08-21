//
//  SegmentedControl.h
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VehicleSelectorButtonType) {
    VehicleSelectorButtonType_Train = 0,
    VehicleSelectorButtonType_Bus = 1,
    VehicleSelectorButtonType_Flight = 2,
    VehicleSelectorButtonType_Count // Do not remove
};

@protocol VehicleSelectorDelegate <NSObject>

- (void)vehicleSelected:(VehicleSelectorButtonType)type;

@end

@interface VehicleSelector : UIView

@property (nonatomic, weak) IBOutlet id<VehicleSelectorDelegate> delegate;

- (void)selectButton:(VehicleSelectorButtonType)type;

@end
