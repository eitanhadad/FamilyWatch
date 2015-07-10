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
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
- (void)setupLocalNotifications;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property MotionHistory *history;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

//bluetooth manager property
@property (nonatomic) CBCentralManager *bluetoothManager;

@property (strong, nonatomic) IBOutlet UILabel *speed;

#define TRANSFER_SERVICE_UUID           @"FB694B90-F49E-4597-8306-171BBA78F846"
#define TRANSFER_CHARACTERISTIC_UUID    @"EB6727C4-F184-497A-A656-76B0CDAC633A"


@end

