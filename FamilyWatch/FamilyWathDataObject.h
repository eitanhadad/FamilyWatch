//
//  FamilyWathDataObject.h
//  FamilyWatch
//
//  Created by Eitan Doron on 7/12/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataObject.h"

@interface FamilyWathDataObject : AppDataObject
{
    NSString*	language;
    NSString*   audioDeviceName;
}

@property (nonatomic, retain) NSString* audioDeviceName;
@property (nonatomic, retain) NSString* language;

@end
