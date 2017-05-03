//
//  AddReminderViewController.m
//  LocationReminder
//
//  Created by Rio Balderas on 5/2/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "AddReminderViewController.h"

@interface AddReminderViewController ()<UITextFieldDelegate>

@property(weak, nonatomic) UITextField *locationNameTextField;
@property(weak, nonatomic) UITextField *locationRadiusTextField;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Annotation Title:%@", self.annotationTitle);
    NSLog(@"Coordinates: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
    
}
- (IBAction)locationNameTextField:(UITextField *)sender {
    
}
- (IBAction)locationRadiusTextField:(UITextField *)sender {
}

@end
