//
//  MyAnnotation.m
//  MapDemo
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}
@end
