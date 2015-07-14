//
//  ConfigAttributesViewController.h
//  FamilyWatch
//
//  Created by Eitan Doron on 6/18/15.
//  Copyright (c) 2015 Eitan Doron. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConfigAttributesViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *languageLabel;
@property (strong, nonatomic) IBOutlet UITextField *languageText;
@property (strong, nonatomic) IBOutlet UILabel *carBlueToothNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *carBlueToothNameText;
@property (nonatomic, strong) NSString *sectionName;

@end
