//
//  AppDelegateProtocol.h
//  FamilyWatch
//
//  Created by Eitan Doron on 7/12/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDataObject;

@protocol AppDelegateProtocol

- (AppDataObject*) theAppDataObject;

@end
