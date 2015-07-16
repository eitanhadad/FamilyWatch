//
//  ViewController.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/6/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "ViewController.h"
#import "FamilyWatchDataObject.h"
#import "AppDelegateProtocol.h"

static BOOL *carAudioActivated;

@interface ViewController ()

@property NSMutableArray *arr;
@property double lastRecordedSpeed;
@property NSDate* lastTimeStamp;
@property NSThread *watchNotificationThread;
- (void)makeSoundAlert:(NSString*)text speechRate:(double) rate;

@end

@implementation ViewController


/**
 Implementation of the AppDelegateProtocol
 **/


- (FamilyWatchDataObject*) theAppDataObject;
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    FamilyWatchDataObject* theDataObject;
    theDataObject = (FamilyWatchDataObject*) theDelegate.theAppDataObject;
    return theDataObject;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    carAudioActivated = false;
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // Check if the app can respond to the new selector found in iOS 8. If so, request it.
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
        // Or [self.locationManager requestWhenInUseAuthorization];
        
        /** --> Bluetooth Device managemnet
        
        self.bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self
                                                                 queue:nil
                                                               options:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0]
                                                                                                   forKey:CBCentralManagerOptionShowPowerAlertKey]];
         **/
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myInterruptionSelector:)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myRouteChangeSelector:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:nil];
    
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:backgroundView];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    _arr = [[NSMutableArray alloc] init];
    [self.arr addObject:self];
    
    FamilyWatchDataObject* theDataObject = [self theAppDataObject];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.history = theDataObject.history;
    theDataObject.language = [prefs stringForKey:@"language"];
    theDataObject.audioDeviceName = [prefs stringForKey:@"audioDeviceName"];
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.locationManager startUpdatingLocation];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if(carAudioActivated)
        return;
    
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
        self.lastTimeStamp = nil;
        
    }
    //Getting ready to stop car, running, walking or idle
    else if(self.location.speed < 1)
    {
        //Car was driving and slowed down
        if([self.history.state  isEqual: @"DRIVING"])
           {
               // Moving very slowly - IDLE START
               if(self.location.speed < 0.8)
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
    
}

- (void)viewWillAppear:(BOOL)animated {
    //[self makeSoundAlert: @"FamilyRideWatch is now online" speechRate:0.05];
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



/** --> Bluetooth Management

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // This delegate method will monitor for any changes in bluetooth state and respond accordingly
    NSString *stateString = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
    switch(self.bluetoothManager.state)
    {
        case CBCentralManagerStateResetting: stateString = @"The connection with the system service was momentarily lost, update imminent."; break;
        case CBCentralManagerStateUnsupported: stateString = @"The platform doesn't support Bluetooth Low Energy."; break;
        case CBCentralManagerStateUnauthorized: stateString = @"The app is not authorized to use Bluetooth Low Energy."; break;
        case CBCentralManagerStatePoweredOff: stateString = @"Bluetooth is currently powered off."; break;
        case CBCentralManagerStatePoweredOn: stateString = @"Bluetooth is currently powered on and available to use.";
            [self.bluetoothManager scanForPeripheralsWithServices:nil options:options];
            
            
            NSLog(@"Scanning started");
            break;
        default: stateString = @"State unknown, update imminent."; break;
            
    }
    NSLog(@"Bluetooth State: %@",stateString);
}



- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI {
    
    NSLog(@"Discovered %@", peripheral.name);
    NSLog(@"Description Is %@", advertisementData.description);
    //NSLog(@"Discovered %@", peripheral.UUID);
}

**/


- (id)init
{
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myInterruptionSelector:)
                                                     name:AVAudioSessionInterruptionNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myRouteChangeSelector:)
                                                     name:AVAudioSessionRouteChangeNotification
                                                   object:nil];
    }
    return self;
}



/**
 IOS 7.x +
 **/

- (BOOL)checkAvailableInputsForPortName:(NSString*)portName
{
    // portDesc.portType could be for example - BluetoothHFP, MicrophoneBuiltIn, MicrophoneWired
    NSArray *availInputs = [[AVAudioSession sharedInstance] availableInputs];
    
    int count = [availInputs count];
    for (int k = 0; k < count; k++) {
        AVAudioSessionPortDescription *portDesc = [availInputs objectAtIndex:k];
        if([portDesc.portName  isEqual: portName])
            return true;
        //NSLog(@"input%i port type %@", k+1, portDesc.portType);
        //NSLog(@"input%i port name %@", k+1, portDesc.portName);
    }
    return false;
}

/**
 IOS 6.x
 **/

- (void)myRouteChangeSelector:(NSNotification*)notification
{
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    NSArray *inputsForRoute = currentRoute.inputs;
    NSArray *outputsForRoute = currentRoute.outputs;
    AVAudioSessionPortDescription *outPortDesc = [outputsForRoute objectAtIndex:0];
    NSLog(@"current outport type %@", outPortDesc.portType);
    AVAudioSessionPortDescription *inPortDesc = [inputsForRoute objectAtIndex:0];
    NSString *newPortName = inPortDesc.portName;
    NSLog(@"current inPort type %@", inPortDesc.portType);
    NSLog(@"current inPort name %@", newPortName);
    
    
    FamilyWatchDataObject* theDataObject = [self theAppDataObject];
    NSString* settingsPortName = theDataObject.audioDeviceName;
    
    
    if([newPortName  isEqual: settingsPortName ])
    {
        carAudioActivated = true;
        // flush all states - if another thread is active it will exit.
        [self.history flush];
        self.history.state = @"DRIVING_BLUETOOTH";
    }
    
    else if ([self.history.state  isEqual: @"DRIVING_BLUETOOTH"])
    {
        if (![self checkAvailableInputsForPortName:settingsPortName]) {
            carAudioActivated = false;
            self.history.state = @"IDLE";
            self.watchNotificationThread = [[NSThread alloc] initWithTarget:[WatchNotificationAgent class] selector:@selector(NotificationAgentExec:) object:self.arr];
            [self.watchNotificationThread start];
        }
    }
}



- (void)myInterruptionSelector:(NSNotification*)notification
{
    return;
    
}

@end
