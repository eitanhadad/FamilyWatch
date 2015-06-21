//
//  ConfigAttributesViewController.m
//  FamilyWatch
//
//  Created by Eitan Doron on 6/18/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import "ConfigAttributesViewController.h"

@interface ConfigAttributesViewController ()

@end

@implementation ConfigAttributesViewController

@synthesize settingLabel;
@synthesize sectionName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
