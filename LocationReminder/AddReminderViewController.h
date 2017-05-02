//
//  AddReminderViewController.h
//  LocationReminder
//
//  Created by Rio Balderas on 5/2/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface AddReminderViewController : UIViewController

@property(strong, nonatomic) NSString *annotationTitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;//does not need strong or weak because struct

@end
