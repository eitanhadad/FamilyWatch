//
//  MotionHistory.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/7/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MotionHistory : NSObject

@property NSMutableArray *historyArray;

- (BOOL) isAutomative;
- (id) init;
- (BOOL) isSpeedChanged;
- (void) addMotion:(double)speed;


@end
