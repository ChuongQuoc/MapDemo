//
//  MapLoadViewController.h
//  MapDemo
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapLoadViewController : UIViewController
@property (strong,nonatomic) NSArray *mapLocations;
-(void)openInAppleMaps:(id)sender;
@end
