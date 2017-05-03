//
//  ViewController.m
//  LocationReminder
//
//  Created by Rio Balderas on 5/1/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "ViewController.h"
#import "AddReminderViewController.h"
#import "LocationController.h"
@import Parse;
@import MapKit;


@interface ViewController () <MKMapViewDelegate, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//core location
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestPersmissions];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    self.locationManager.delegate = self;
    
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    
//    //testing key
//    testObject[@"testname"] = @"Jay Balderas";
//    
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"success saving test object");
//        } else {
//            NSLog(@"There was a problem saving. Save Error: %@", error.localizedDescription);
//        }
//    }];
    
//    //creating a query to server to show the one line above.
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//    //this will find all the objects and spit them all out
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//        } else {
//            NSLog(@"Query Results %@", objects);
//            //spits this out
////            Query Results (
////            "<TestObject: 0x6080000b0bc0, objectId: XWZrBNYWwi, localId: (null)> {\n    testname = \"Jay Balderas\";\n}"
////            )
//        }
//    }];
}

-(void)requestPersmissions{
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100; //meters(how often it will updated so every movement of 100 meters it will update)
    
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"AddReminderViewController"] && [sender isKindOfClass:[MKAnnotationView class]]) {
        MKAnnotationView *annotationView = (MKAnnotationView *)sender;
        
        AddReminderViewController *newReminderViewController = (AddReminderViewController *)segue.destinationViewController;
        //passing over data here through the annotation
        newReminderViewController.coordinate = annotationView.annotation.coordinate;
        newReminderViewController.annotationTitle = annotationView.annotation.title;
        newReminderViewController.title = annotationView.annotation.title;
        
    }
}



- (IBAction)myHouseButtonPressed:(id)sender {
    
    //since its a struct and not a reference, coordinate doesn't need a pointer
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6194608,-122.3376105);
    
    //create a region with coodinate, first is coodinate and others are range.
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 100.0, 100.0);
    
    [self.mapView setRegion:region animated:YES];
    
}


- (IBAction)mySchoolButtonPressed:(id)sender {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6181772,-122.3517001);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 100.0, 100.0);
    
//    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
//    point.coordinate = coordinate;
//    point.title = @"school";
//    [self.mapView setCenterCoordinate:coordinate animated:YES];
    
    [self.mapView setRegion:region animated:YES];
    
}
- (IBAction)oneDollarButtonPressed:(id)sender {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6015181,-122.3333922);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 100.0, 100.0);
    
    [self.mapView setRegion:region animated:YES];
    
}


- (IBAction)userLongPressed:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        
        newPoint.coordinate = coordinate;
        newPoint.title = @"new location";
        
        [self.mapView addAnnotation:newPoint];
    }
}







-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    annotationView.annotation = annotation;
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES; //defaults to NO
    
    UIButton *rightCalloutAccessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; //callout button
    
    annotationView.rightCalloutAccessoryView = rightCalloutAccessory;
    
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"Accessory Tapped!");
    [self performSegueWithIdentifier:@"AddReminderViewController" sender:view];
    
    
}
-(void)locationControllerUpdatedLocation:(CLLocation *)location{
    NSLog(@"Coordinate: %f, %f - Altitude:%f", location.coordinate.latitude, location.coordinate.longitude, location.altitude);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0);
    
    [self.mapView setRegion:region animated:YES];
}


@end
