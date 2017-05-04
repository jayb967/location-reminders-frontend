//
//  AddReminderViewController.m
//  LocationReminder
//
//  Created by Rio Balderas on 5/2/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "AddReminderViewController.h"
#import "Reminder.h"//access to model object

#import "LocationController.h"
@import ContactsUI;
@import MessageUI;



@interface AddReminderViewController ()<UITextFieldDelegate, CNContactPickerDelegate, MFMessageComposeViewControllerDelegate>

@property(weak, nonatomic) UITextField *locationNameTextField;
@property(weak, nonatomic) UITextField *locationRadiusTextField;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Annotation Title:%@", self.annotationTitle);
    NSLog(@"Coordinates: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
    
}
- (IBAction)locationNameTextField:(UITextField *)sender {
    self.annotationTitle = [NSString stringWithString:self.locationNameTextField.text];
}


- (IBAction)radiusSliderChangedValue:(UISlider *)sender {
    NSNumber *radiusNumber = [NSNumber numberWithInt:self.radiusSlider.value];
    self.radiusLabel.text = [NSString stringWithFormat:@"%@ Meters wide", radiusNumber];
    
}
- (IBAction)saveRegionButtonPressed:(UIButton *)sender {
    
    [self newReminderParseSave];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textSendPressed:(UIButton *)sender {
    CNContactPickerViewController *contactPick = [[CNContactPickerViewController alloc]init];
    contactPick.delegate = self;
    contactPick.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    
    [self presentViewController:contactPick animated:YES completion:nil];
}

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts{
    self.contactNumber = [[NSMutableArray alloc] init];
//    CNContact *contact=[contacts objectAtIndex:0];
    for (CNContact *contact in contacts ) {
            NSArray <CNLabeledValue<CNPhoneNumber *> *> *phoneNumber = contact.phoneNumbers;
            CNLabeledValue<CNPhoneNumber *> *firstPhone = [phoneNumber firstObject];
            CNPhoneNumber *number = firstPhone.value;
            NSString *digits = number.stringValue;
            //-----------------path to contact number----------------------
            //"<CNContact: 0x1047798a0: identifier=7B542B98-3142-40E0-AC52-C7969A2FC250, givenName=Aaron. LA, familyName=, organizationName=, phoneNumbers=(\n    \"<CNLabeledValue: 0x170a76780: identifier=6CA64F0D-CC2A-4396-9316-9AD5115B5FB3, label=_$!<Mobile>!$_, value=<CNPhoneNumber: 0x17062cb00: countryCode=us, digits=6263783084>>\"\n), emailAddresses=(not fetched), postalAddresses=(not fetched)>"
            [self.contactNumber addObject:[NSString stringWithFormat:@"%@", digits]];
    
        
    }
    [self sendTextLocation];
}

-(void)sendTextLocation{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    controller.recipients = self.contactNumber;
    [controller setMessageComposeDelegate:self];
    
    NSString *theLocation = [[NSString alloc] initWithFormat:@"http://maps.apple.com/??saddr=Current%%20Location&daddr=%1.6f,%1.6f", self.coordinate.latitude, self.coordinate.longitude];
    
    
    if([MFMessageComposeViewController canSendText])
    {
        [controller setBody:theLocation];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self presentViewController:controller animated:YES completion:NULL];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)newReminderParseSave{
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
            //            CGFloat radius = 100; //for lab coming from UISlider/UITextField from user
            NSNumber *radius = [NSNumber numberWithInt:self.radiusSlider.value];
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius: [radius doubleValue]];
            
            //checking to see if user allows to watch for regions
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:[radius doubleValue] identifier:newReminder.name];
                
                [LocationController.shared startMonitoringForRegion:region];
                
            }
            
            self.completion(circle);//this is handing it the circle defined
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}




@end
