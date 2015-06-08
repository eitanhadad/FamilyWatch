//
//  ViewController.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/6/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MotionHistory.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@property (strong, nonatomic) IBOutlet UILabel *speed;
@property MotionHistory *history;

@end

