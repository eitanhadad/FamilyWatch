//
//  ConfigAttributesViewController.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/18/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConfigAttributesViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *settingLabel;
@property (strong, nonatomic) IBOutlet UITextField *languageLabel;
@property (nonatomic, strong) NSString *sectionName;
@property (strong, nonatomic) IBOutlet UITextField *languageValue;
@property (strong, nonatomic) IBOutlet UILabel *carBlueToothDeviceLabel;
@property (strong, nonatomic) IBOutlet UITextField *carBlueToothDeviceValue;

@end
