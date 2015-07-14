//
//  FamilyWathDataObject.m
//  FamilyWatch
//
//  Created by Eitan Doron on 7/12/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "FamilyWathDataObject.h"

@implementation FamilyWathDataObject

@synthesize language;
@synthesize audioDeviceName;

#pragma mark -
#pragma mark -Memory management methods

- (void)dealloc
{
    //Release any properties declared as retain or copy.
    self.language = nil;
    self.audioDeviceName = nil;
}

@end
