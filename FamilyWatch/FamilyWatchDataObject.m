//
//  FamilyWatchDataObject.m
//  FamilyWatch
//
//  Created by Eitan Doron on 7/14/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "FamilyWatchDataObject.h"

@implementation FamilyWatchDataObject
@synthesize language;
@synthesize audioDeviceName;
@synthesize history;


#pragma mark -
#pragma mark -Memory management methods

- (void)dealloc
{
    //Release any properties declared as retain or copy.
    self.language = nil;
    self.audioDeviceName = nil;
    self.history = nil;
}

@end
