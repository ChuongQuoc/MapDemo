//
//  MapLoadViewController.m
//  MapDemo
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MapLoadViewController.h"

@interface MapLoadViewController ()

@end

@implementation MapLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mapLocations = @[@{@"name" : @"Chợ Hoàng Hoa Thám",@"lat" : @10.798231, @"lng" : @106.647049}];
    //create button to open mapview
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    openButton.frame = CGRectMake(20, 60, 280, 40);
    [openButton setTitle:[NSString stringWithFormat:@"Open Hoàng Hoa Thám Market in Maps"] forState:UIControlStateNormal];
    [openButton addTarget:self action:@selector(openInAppleMaps:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openButton];
}

-(void)openInAppleMaps:(id)sender{
    double lat = [self.mapLocations[0][@"lat"] doubleValue];
    double lng = [self.mapLocations[0][@"lng"] doubleValue];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
    MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:coord addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:placemark];
    mapItem.name = self.mapLocations[0][@"name"];
    [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsMapTypeKey:@2,MKLaunchOptionsMapCenterKey:[NSValue valueWithMKCoordinate:placemark.coordinate], MKLaunchOptionsShowsTrafficKey:@YES}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
