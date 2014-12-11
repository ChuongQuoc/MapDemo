//
//  MapViewController.h
//  MapDemo
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#define kCLDistanceFilterNone 500
#define kCLLocationAccuracyBest 400
#define kGOOGLE_API_KEY @"AIzaSyCLb_MossJqt4b1_QAhr-moeLMBuNTUigk"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManger;
    CLLocationCoordinate2D currentCentre;
    int currentDist;
    NSString *icon;
    
}
@property (nonatomic,strong) MKMapView *mapView;
@property BOOL userLocationUpdated;
@property (nonatomic,strong) UIToolbar *toolbar,*bottomToolbar;
@property (nonatomic,strong) UIBarButtonItem *barItem,*restaurantItem,*atmItem,*userLocationItem;

@property (nonatomic,strong) NSMutableArray *arrAnnotation;
@end
