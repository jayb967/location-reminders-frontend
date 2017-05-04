//
//  LocationController.m
//  LocationReminder
//
//  Created by Rio Balderas on 5/2/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "LocationController.h"
#import "ViewController.h"
#import "AddReminderViewController.h"

@import MapKit;
@import UserNotifications;

@interface LocationController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) CLLocationManager *requestPersmissions;
@end

@implementation LocationController


+ (LocationController *)shared {
    static LocationController *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc]init];
    return self;
}

-(void)requestPersmissions{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100; //meters(how often it will updated so every movement of 100 meters it will update)
    
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

-(void)startMonitoringForRegion:(CLRegion *) region{
    [self.locationManager startMonitoringForRegion:region];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.lastObject;
    
    [self.delegate locationControllerUpdatedLocation:location];
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"User did ENTER Region: %@", region.identifier);
    
    //content that will be assigned to the notification
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    content.title = @"Reminder!";
    content.body = [NSString stringWithFormat:@"%@", region.identifier];
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Location Entered" content:content trigger:trigger];
    
    UNUserNotificationCenter *currentCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    [currentCenter removeAllPendingNotificationRequests];//doc says to do so
    [currentCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"error posting user notification:%@", error.localizedDescription);
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"User did EXIT Region: %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"There was an Error: %@", error.localizedDescription);//ignore if in simulator
}

-(void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit{
    NSLog(@"this is here for no reason..here is a vist %@", visit);
}

@end
