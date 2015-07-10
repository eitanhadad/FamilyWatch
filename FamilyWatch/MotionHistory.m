//
//  MotionHistory.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/7/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "MotionHistory.h"

static NSString* IDLE = @"IDLE";

@interface MotionHistory()


@end

@implementation MotionHistory



-(id)init
{
    self = [super init];
    if(self)
    {
        _historyArray = [[NSMutableArray alloc] init];
        self.state = nil;
    }
    
    
    return self;
}

- (BOOL) isAutomative
{
    BOOL result = true;
    
    
    return result;
    
}

/**
 checks the state property of the MotionHistory
 **/

- (BOOL) isState:(NSString*)paramState
{
    return self.state == paramState;
}



- (BOOL) isSpeedChanged
{
    return true;
}
            
            
- (void) addMotion:(double)speed
{
    
}

- (void) flush
{
    _historyArray = [[NSMutableArray alloc] init];
    self.state = nil;
    
}




@end
