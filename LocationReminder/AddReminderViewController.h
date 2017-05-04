//
//  AddReminderViewController.h
//  LocationReminder
//
//  Created by Rio Balderas on 5/2/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@import MessageUI;
@import ContactsUI;

//          ^ means that it is a block
typedef void(^NewReminderCreatedCompletion)(MKCircle *);



@interface AddReminderViewController : UIViewController<MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;

@property(strong, nonatomic) NSString *annotationTitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;//does not need strong or weak because struct
@property(strong, nonatomic) NSMutableArray *contactNumber;

@property(strong, nonatomic) NewReminderCreatedCompletion completion;

@end
