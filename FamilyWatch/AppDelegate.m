//
//  AppDelegate.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/6/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    // use vibrant when alarm is shown
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    if (notification) {
        [self showAlarm:notification.alertBody];
        NSLog(@"AppDelegate didFinishLaunchingWithOptions");
        application.applicationIconBadgeNumber = 0;
    }
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    [self.window makeKeyAndVisible];
    [self prepareAudioSession];
    
    //instantiating a history object
    self.history = [[MotionHistory alloc] init];
    //instantiating a FamilyWatchDataObject object
    self.theAppDataObject = [[FamilyWatchDataObject alloc] init];
    //attaching the FamilyWatchDataObject object with the history object
    self.theAppDataObject.history = self.history;

    // Override point for customization after application launch.
    return YES;
}

/**
 Prepare Audio Session
 **/

- (BOOL)prepareAudioSession {
    
    // deactivate session
    BOOL success = [[AVAudioSession sharedInstance] setActive:NO error: nil];
    if (!success) {
        NSLog(@"deactivationError");
    }
    
    // set audio session category AVAudioSessionCategoryPlayAndRecord options AVAudioSessionCategoryOptionAllowBluetooth
    success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
    if (!success) {
        NSLog(@"setCategoryError");
    }
    
    // activate audio session
    success = [[AVAudioSession sharedInstance] setActive:YES error: nil];
    if (!success) {
        NSLog(@"activationError");
    }
    return success;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [self showAlarm:notification.alertBody];
    application.applicationIconBadgeNumber = 0;
    NSLog(@"AppDelegate didReceiveLocalNotification %@", notification.userInfo);
}

/**
 Present alarm
 **/

- (void)showAlarm:(NSString *)text {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alarm"
                                                        message:text
                                                       delegate:self
                                              cancelButtonTitle:@"Ignore Alarm"
                                              otherButtonTitles:@"Thank You", nil];
    [alertView show];
    
}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger) buttonIndex{
    
    if (buttonIndex == 1) { //Thank You
        self.theAppDataObject.history.state = @"MARKED_THANK_YOU";
    } else { //0 Ignore
        self.theAppDataObject.history.state = @"MARKED_IGNORE";
    }
}

@end
