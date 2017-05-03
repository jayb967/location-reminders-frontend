//
//  LocationController.h
//  LocationReminder
//
//  Created by Rio Balderas on 5/2/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;



@protocol LocationControllerDelegate <NSObject>
@required
-(void)locationControllerUpdatedLocation:(CLLocation *)location;
@end

@interface LocationController : NSObject

@property (weak, nonatomic) id delegate;

+(LocationController *)shared;

@end
