//
//  FamilyWatchDataObject.h
//  FamilyWatch
//
//  Created by Eitan Doron on 7/14/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataObject.h"
#import "MotionHistory.h"

@interface FamilyWatchDataObject : AppDataObject
{
    NSString*	language;
    NSString*	audioDeviceName;
    MotionHistory* history;
}

@property (nonatomic, copy) NSString* language;
@property (nonatomic, retain) NSString* audioDeviceName;
@property (nonatomic, retain) MotionHistory* history;

@end
