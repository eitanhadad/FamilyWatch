//
//  WatchNotificationAgent.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/7/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "WatchNotificationAgent.h"

static BOOL *isMoving;

@implementation WatchNotificationAgent


+ (void) NotificationAgentExec:(NSMutableArray*) arr
{
    ViewController *currentViewParent = arr.firstObject;
    
    while (! isMoving) {
        [currentViewParent setupLocalNotifications];
        usleep(10000);
    
    }

    
}

/**
 set for the static variable
 **/

+ (void) setIsMoving:(BOOL*) val
{
    isMoving = val;
}

@end
