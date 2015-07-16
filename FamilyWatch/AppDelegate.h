//
//  AppDelegate.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/6/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"
#import "AppDelegateProtocol.h"
#import "FamilyWatchDataObject.h"
#import "MotionHistory.h"

@class FamilyWatchDataObject;

@interface AppDelegate : UIResponder <UIApplicationDelegate, AppDelegateProtocol>

{
    
    FamilyWatchDataObject* theAppDataObject;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, retain) FamilyWatchDataObject* theAppDataObject;
@property MotionHistory *history;

@end

