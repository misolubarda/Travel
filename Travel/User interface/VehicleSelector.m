//
//  SegmentedControl.m
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "VehicleSelector.h"
#import "HMSegmentedControl.h"

@interface VehicleSelector ()

@property (nonatomic, strong) HMSegmentedControl *control;

@end

@implementation VehicleSelector

- (void)awakeFromNib {
    [super awakeFromNib];
    
    HMSegmentedControl *control = [[HMSegmentedControl alloc] initWithSectionTitles:[self buttonTitles]];
    control.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    control.backgroundColor = [UIColor clearColor];
    control.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    control.indexChangeBlock = ^(NSInteger index){
        if ([self.delegate respondsToSelector:@selector(vehicleSelected:)]) {
            [self.delegate vehicleSelected:index];
        }
    };
    control.translatesAutoresizingMaskIntoConstraints = NO;
    self.control = control;
    [self addSubview:control];
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[control]-0-|" options:0 metrics:nil views:@{@"control" : control}];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[control]-0-|" options:0 metrics:nil views:@{@"control" : control}]];
    
    [self addConstraints:constraints];
}

- (NSArray *)buttonTitles {
    
    NSArray *titles = @[];
    
    for (int i = 0; i < VehicleSelectorButtonType_Count; i++) {
        titles = [titles arrayByAddingObject:[self buttonTitleForType:i]];
    }
    
    return titles;
}

- (NSString *)buttonTitleForType:(VehicleSelectorButtonType)type {
    switch (type) {
        case VehicleSelectorButtonType_Bus: return @"Bus";
        case VehicleSelectorButtonType_Train: return @"Train";
        case VehicleSelectorButtonType_Flight: return @"Flight";
        case VehicleSelectorButtonType_Count: return @"";
    }
}

- (void)selectButton:(VehicleSelectorButtonType)type {
    self.control.selectedSegmentIndex = type;
}

@end
