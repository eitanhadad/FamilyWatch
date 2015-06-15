//
//  AppDelegate.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/6/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;


@end

