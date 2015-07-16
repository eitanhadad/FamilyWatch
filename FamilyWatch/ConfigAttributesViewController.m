//
//  ConfigAttributesViewController.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/18/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "ConfigAttributesViewController.h"
#import "FamilyWatchDataObject.h"
#import "AppDelegateProtocol.h"

@interface ConfigAttributesViewController ()

@end

@implementation ConfigAttributesViewController

@synthesize settingLabel;
@synthesize sectionName;



/**
 Implementation of the AppDelegateProtocol
 **/


- (FamilyWatchDataObject*) theAppDataObject;
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    FamilyWatchDataObject* theDataObject;
    theDataObject = (FamilyWatchDataObject*) theDelegate.theAppDataObject;
    return theDataObject;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setting up delegation for text fields
    self.languageValue.delegate = self;
    self.carBlueToothDeviceValue.delegate = self;
    
    // Configure the keyboard to show the Done button
    self.languageValue.returnKeyType = UIReturnKeyDone;
    self.carBlueToothDeviceValue.returnKeyType = UIReturnKeyDone;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.languageValue.text = [prefs stringForKey:@"language"];
    self.carBlueToothDeviceValue.text = [prefs stringForKey:@"audioDeviceName"];
    
    
    
    // currently attributes will be updated statically
    
    if ([sectionName  isEqual: @"Language"]) {
        settingLabel.text = @"Language";
    }
    else
    {
        if ([sectionName  isEqual: @"Bluetooth"])
        {
            settingLabel.text = @"BlueTooth Name";
        }
    }
}
    // Do any additional setup after loading the view.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    FamilyWatchDataObject* theDataObject = [self theAppDataObject];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([textField.accessibilityLabel isEqualToString:@"language"])
    {
        theDataObject.language = textField.text;
        [prefs setObject:textField.text forKey:@"language"];
    }
    
    else if ([textField.accessibilityLabel isEqualToString:@"deviceName"])
    {
        theDataObject.audioDeviceName = textField.text;
        [prefs setObject:textField.text forKey:@"audioDeviceName"];
    }
    
    
}

/**
 Dismiss the keyboard
 **/

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;  //dismisses the keyboard
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
