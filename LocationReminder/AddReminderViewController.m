//
//  AddReminderViewController.m
//  LocationReminder
//
//  Created by Rio Balderas on 5/2/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "AddReminderViewController.h"
#import "Reminder.h"//access to model object

@interface AddReminderViewController ()<UITextFieldDelegate>

@property(weak, nonatomic) UITextField *locationNameTextField;
@property(weak, nonatomic) UITextField *locationRadiusTextField;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Reminder *newReminder = [Reminder object];
    
    newReminder.name = self.annotationTitle;
    newReminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Annotation Title: %@", self.annotationTitle);
        NSLog(@"Coordinates: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
        
        NSLog(@"save reminder succesful:%i - Error: %@ ", succeeded, error.localizedDescription);
        
        //this calls the function "ReminderSavedToParse"
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderSavedToParse" object:nil];
        
        if (self.completion) {
            CGFloat radius = 100; //for lab coming from UISlider/UITextField from user
            
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius];
            
            self.completion(circle);//this is handing it the circle defined
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
    NSLog(@"Annotation Title:%@", self.annotationTitle);
    NSLog(@"Coordinates: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
    
}
- (IBAction)locationNameTextField:(UITextField *)sender {
    
}
- (IBAction)locationRadiusTextField:(UITextField *)sender {
}
- (IBAction)radiusSliderChangedValue:(UISlider *)sender {
    NSNumber *radiusNumber = [NSNumber numberWithInt:self.radiusSlider.value];
    self.radiusLabel.text = [NSString stringWithFormat:@"%@", radiusNumber];
    
}

@end
