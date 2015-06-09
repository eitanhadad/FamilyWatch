//
//  WatchNotificationAgent.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/7/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface WatchNotificationAgent : NSThread

+ (void) NotificationAgentExec:(NSMutableArray*) arr;
+ (void) setIsMoving:(BOOL*) val;

@end
