//
//  MotionHistory.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/7/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "MotionHistory.h"

@interface MotionHistory()


- (void) setHistoryEnum:(NSEnumerator*)histEnum;

@end

@implementation MotionHistory



-(id)init
{
    self = [super init];
    if(self)
    {
        _historyEnum = [[NSEnumerator alloc] init];
    }
    
    
    return self;
}

- (BOOL) isAutomative
{
    BOOL result = true;
    
    
    return result;
    
}

@end
