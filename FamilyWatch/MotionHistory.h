//
//  MotionHistory.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/7/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MotionHistory : NSObject

@property NSEnumerator *historyEnum;

- (BOOL) isAutomative;
- (id)init;


@end
