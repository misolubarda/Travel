//
//  SegmentedControl.h
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SegmentedControlButtonType) {
    SegmentedControlButtonType_Flight,
    SegmentedControlButtonType_Bus,
    SegmentedControlButtonType_Train
};

@protocol Segmented <NSObject>

<#methods#>

@end

@interface SegmentedControl : UIView

@property (nonatomic, weak) id delegate;

@end
