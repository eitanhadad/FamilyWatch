//
//  ViewController.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/6/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // Code to check if the app can respond to the new selector found in iOS 8. If so, request it.
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
        // Or [self.locationManager requestWhenInUseAuthorization];
    }
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    self.location = locations.lastObject;
    //self.coordinateLat.text = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
    //self.coordinateLon.text = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
    //self.altitude.text = [NSString stringWithFormat:@"%f", self.location.altitude];
    //self.hAccuracy.text = [NSString stringWithFormat:@"%f", self.location.horizontalAccuracy];
    //self.vAccuracy.text = [NSString stringWithFormat:@"%f", self.location.verticalAccuracy];
    //self.timestamp.text = [NSString stringWithFormat:@"%@", self.location.timestamp];
    self.speed.text = [NSString stringWithFormat:@"%f", self.location.speed];
    //self.course.text = [NSString stringWithFormat:@"%f", self.location.course];
    NSLog(@"%@", self.location.description);
    
}

@end
