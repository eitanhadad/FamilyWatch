//
//  ViewController.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/6/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSMutableArray *arr;
@property double lastRecordedSpeed;
@property NSDate* lastTimeStamp;
@property NSThread *watchNotificationThread;
- (void)makeSoundAlert:(NSString*)text speechRate:(double) rate;

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
    
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:backgroundView];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    _arr = [[NSMutableArray alloc] init];
    [self.arr addObject:self];
    
    
    _history = [[MotionHistory alloc] init];
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
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
    
    
    
    
    
    //Driving
    if(self.location.speed > 5)
    {
        self.history.state = @"DRIVING";
        
    }
    //Getting ready to stop car, running, walking or idle
    else if(self.location.speed < 1)
    {
        //Car was driving and slowed down
        if([self.history.state  isEqual: @"DRIVING"])
           {
               // Moving very slowly - IDLE START
               if(self.location.speed < 0.5)
               {
                   
                   // taking note of the timestamp when we first hit the IDLE state
                   if(!self.lastTimeStamp)
                       self.lastTimeStamp = self.location.timestamp;
                   
                   NSTimeInterval diff = [self.location.timestamp timeIntervalSinceDate:self.lastTimeStamp];
                   // It's not the traffic light we are waiting on... I don't think it's a traffic jam either
                   if( diff > 180 )
                   {
                       // resetting lastTimeStamp
                       self.lastTimeStamp = nil;
                       self.history.state = @"IDLE";
                       self.watchNotificationThread = [[NSThread alloc] initWithTarget:[WatchNotificationAgent class] selector:@selector(NotificationAgentExec:) object:self.arr];
                       [self.watchNotificationThread start];
                       NSLog(@"%@", self.location.description);
                   }
                   
               }
               // if speed is higher than 0.5 set lastTimeStamp to currentTimeStamp
               else
               {
                   self.lastTimeStamp = self.location.timestamp;
                   self.history.state = @"DRIVING";
                   
               }
               
           }
        
        
    }
    
  /**  if (self.location.speed == 0)
    {
        if(self.lastRecordedSpeed != 0)
        {
            self.lastRecordedSpeed = 0;
            [WatchNotificationAgent setIsMoving:(BOOL*)false];
            if(self.history.isAutomative)
            {
                [NSThread detachNewThreadSelector:@selector(NotificationAgentExec:) toTarget:[WatchNotificationAgent class] withObject:self.arr];
            }
            else
            {
                [WatchNotificationAgent setIsMoving:(BOOL*)true];
            }
        }
        
            
    }
    self.lastRecordedSpeed = self.location.speed;
    NSLog(@"%@", self.location.description);
    
   **/
}

- (void)viewWillAppear:(BOOL)animated {
    [self makeSoundAlert: @"FamilyRideWatch is now online" speechRate:0.05];
}




- (void)makeSoundAlert:(NSString*)text speechRate:(double) rate
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    utterance.rate = rate;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-au"];
    [self.synthesizer speakUtterance:utterance];
    
}



- (void)setupLocalNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // current time plus 0 secs
    NSDate *now = [NSDate date];
    NSDate *dateToFire = [now dateByAddingTimeInterval:0];
    
    NSLog(@"now time: %@", now);
    NSLog(@"fire time: %@", dateToFire);
    
    localNotification.fireDate = dateToFire;
    localNotification.alertBody = @"Wait, Before you leave the car please make sure you have not forgotten anyone";
    //localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1; // increment
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Object 1", @"Key 1", @"Object 2", @"Key 2", nil];
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    [self makeSoundAlert:@"Wait, Before you leave the car please make sure you have not forgotten anyone" speechRate:0.05];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0)
    {
        NSLog(@"You have clicked Cancel");
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"You have clicked GOO");
    }
}

@end
