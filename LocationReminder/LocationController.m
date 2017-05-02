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

@implementation LocationController

@synthesize locationManager;
@synthesize location;

+ (LocationController *)shared {
    static LocationController *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (LocationController *)init {
    self = [super init];
    locationManager = [[CLLocationManager alloc]init];
    location = [[CLLocation alloc]init];
    return self;
}

-(void)locationControllerUpdatedLocation:(CLLocation *)location{
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.lastObject;
    
    [self.delegate locationControllerUpdatedLocation:location];
    
}

@end
