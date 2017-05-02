//
//  ViewController.m
//  LocationReminder
//
//  Created by Rio Balderas on 5/1/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "ViewController.h"

@import Parse;
@import MapKit;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//core location
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestPersmissions];
    self.mapView.showsUserLocation = YES;
    
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
    [self.locationManager requestAlwaysAuthorization];
    
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
    
    [self.mapView setRegion:region animated:YES];
    
}
- (IBAction)oneDollarButtonPressed:(id)sender {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6015181,-122.3333922);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 100.0, 100.0);
    
    [self.mapView setRegion:region animated:YES];
    
}


//codefellows 47.6181772,-122.3517001
//$1 shots bar 47.6015181,-122.3333922


@end
