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

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.lastObject;
    
    [self.delegate locationControllerUpdatedLocation:location];
    
}

@end
