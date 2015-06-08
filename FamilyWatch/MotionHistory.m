//
//  MotionHistory.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/7/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "MotionHistory.h"

@interface MotionHistory()


@end

@implementation MotionHistory



-(id)init
{
    self = [super init];
    if(self)
    {
        _historyArray = [[NSMutableArray alloc] init];
    }
    
    
    return self;
}

- (BOOL) isAutomative
{
    BOOL result = true;
    
    
    return result;
    
}

- (BOOL) isSpeedChanged
{
    return true;
}
            
            
- (void) addMotion:(double)speed
{
    
}


@end
