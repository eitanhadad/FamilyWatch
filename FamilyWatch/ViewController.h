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
#import "WatchNotificationAgent.h"
#import "AVFoundation/AVFoundation.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
- (void)setupLocalNotifications;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property MotionHistory *history;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

@property (strong, nonatomic) IBOutlet UILabel *speed;


@end

