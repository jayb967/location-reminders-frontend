//
//  Reminder.m
//  LocationReminder
//
//  Created by Rio Balderas on 5/3/17.
//  Copyright © 2017 Jay Balderas. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

//lets them work with parse and subclass the model with
@dynamic name;
@dynamic location;
@dynamic radius;

//overriding load
+(void)load{
    [super load];
    [self registerSubclass];//will account for registering subclass with parse
}
//+ is class method - is instance method
+(NSString *)parseClassName{
    return @"Reminder";//THIS IS WHAT WILL BE REPRESETED AS IN PARSE SERVER (indenty type)
}

@end
