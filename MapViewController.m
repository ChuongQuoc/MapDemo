//
//  MapViewController.m
//  MapDemo
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MapViewController.h"
#import "Object.h"
#import "MBProgressHUD.h"

@interface MapViewController (){
    MBProgressHUD *hud;
    
}

@end

@implementation MapViewController

-(IBAction)doActionBar:(id)sender{
    self.userLocationUpdated = YES;
    [self.mapView removeAnnotations:self.mapView.annotations];
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    NSString *buttonTitle = [button.title lowercaseString];
    if ([buttonTitle isEqualToString:@"bar"]) {
        icon = @"bar.png";
        [self queryGooglePlaces:@"bar"];
    } else if([buttonTitle isEqualToString:@"restaurant"]){
        icon = @"restaurant.png";
        [self queryGooglePlaces:@"restaurant"];
    }else if ([buttonTitle isEqualToString:@"atm"]){
        icon = @"atm.png";
        [self queryGooglePlaces:@"atm"];
    }else if([buttonTitle isEqualToString:@"current location"]){
        NSLog(@"current location");
        [hud show:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [self.mapView setCenterCoordinate:coordinate2D animated:YES];
                MKCoordinateRegion region;
                region = MKCoordinateRegionMakeWithDistance(locationManger.location.coordinate, 2000, 1500);
                [self.mapView setRegion:region animated:YES];
            });
        });
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, 50)];
    [self.toolbar setTintColor:[UIColor whiteColor]];
    [self.toolbar setBarTintColor:[UIColor colorWithRed:18/255.0f green:116/255.0f blue:201/255.0f alpha:1.0]];
    [self.view addSubview:self.toolbar];

    self.barItem = [[UIBarButtonItem alloc]initWithTitle:@"Bar" style:UIBarButtonItemStylePlain target:self action:@selector(doActionBar:)];
    self.restaurantItem = [[UIBarButtonItem alloc]initWithTitle:@"Restaurant" style:UIBarButtonItemStylePlain target:self action:@selector(doActionBar:)];
    self.atmItem = [[UIBarButtonItem alloc]initWithTitle:@"ATM" style:UIBarButtonItemStylePlain target:self action:@selector(doActionBar:)];
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [fixedItem setWidth:45.0f];
    [self.toolbar setItems:@[self.barItem,fixedItem, self.restaurantItem, fixedItem, self.atmItem]];
    
    
    locationManger = [[CLLocationManager alloc]init];
    locationManger.delegate = self;
    [locationManger setDistanceFilter:kCLDistanceFilterNone];
    [locationManger setDesiredAccuracy:kCLLocationAccuracyBest];
    NSString *iosVerion = [[UIDevice currentDevice] systemVersion];
    if ([iosVerion isEqualToString:@"8.0"]) {
        [locationManger requestAlwaysAuthorization];
    }
    
    self.mapView = [[MKMapView alloc]init];
    self.mapView.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + self.toolbar.frame.size.height, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.toolbar.frame.size.height - 50);
    self.mapView.delegate = self;
    //this is default
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.scrollEnabled = YES;
    self.mapView.zoomEnabled = YES;
    [self.view addSubview:self.mapView];
    
    self.bottomToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + self.toolbar.frame.size.height + self.mapView.frame.size.height, self.view.frame.size.width, 50)];
    [self.bottomToolbar setBarTintColor:[UIColor colorWithRed:18/255.0f green:116/255.0f blue:201/255.0f alpha:1.0]];
//    [self.bottomToolbar setBackgroundImage:[[UIImage alloc]init] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.bottomToolbar setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.bottomToolbar];
    self.userLocationItem = [[UIBarButtonItem alloc]initWithTitle:@"Current Location" style:UIBarButtonItemStylePlain target:self action:@selector(doActionBar:)];
    [self.bottomToolbar setItems:@[self.userLocationItem] animated:YES];

    
//    CLLocationCoordinate2D startCenter = CLLocationCoordinate2DMake(10.798231, 106.647049);
//    CLLocationDistance regionWidth = 1500;
//    CLLocationDistance regionHeight = 1500;
//    
//    MKCoordinateRegion startRegion = MKCoordinateRegionMakeWithDistance(startCenter, regionWidth, regionHeight);
//    [self.mapView setRegion:startRegion animated:YES];
    self.mapView.showsUserLocation = YES;
//    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
//    
//    CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake(10.798231, 106.647049);
//    MyAnnotation *annotation = [[MyAnnotation alloc]init];
//    annotation.coordinate = annotationCoordinate;
//    annotation.title = @"Hoàng Hoa Thám Market";
//    annotation.subtitle = @"Market";
//    [self.mapView addAnnotation:annotation];
//    
//    NSArray *locations = @[@{@"name" : @"Shop Thời Trang Little Angle",@"lat" : @10.798133, @"lng" : @106.647358},@{@"name" : @"Quán Chè Mỹ", @"lat" : @10.798031, @"lng" : @106.647084}];
//    for (NSDictionary *location in locations) {
//        CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake([location[@"lat"] doubleValue], [location[@"lng"] doubleValue]);
//        MyAnnotation *annotation = [[MyAnnotation alloc] init];
//        annotation.coordinate = annotationCoordinate;
//        annotation.title = location[@"name"];
//        annotation.subtitle = nil;
//        [self.mapView addAnnotation:annotation];
//    }
//    [locationManger startUpdatingLocation];

}

-(void) queryGooglePlaces: (NSString *) googleType {
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && self.mapView.userLocation != nil) {
        //do your works.
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setMode:MBProgressHUDModeIndeterminate];
        [hud setFrame:CGRectMake(0, 0, 200, 100)];
        [hud setLabelText:@"Finding ..."];
//        [locationManger startUpdatingLocation];
//        self.mapView.showsUserLocation = YES;
            // Build the url string to send to Google. NOTE: The kGOOGLE_API_KEY is a constant that should contain your own API key that you obtain from Google. See this link for more info:
            // https://developers.google.com/maps/documentation/places/#Authentication
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude, [NSString stringWithFormat:@"%i", 1000], googleType, kGOOGLE_API_KEY];
        
            //Formulate the string as a URL object.
        NSURL *googleRequestURL=[NSURL URLWithString:url];
        
            // Retrieve the results of the URL.
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
            if (data == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please try again, google api can not response quickly." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                });
            }else
            {
                [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
            }
        });
    } else {
        //show an alert
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please turn on location services and switch MapDemo to on follow below path here: \nSettings-Privacy-Location Services-MapDemo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)fetchedData:(NSData *)responseData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //parse out the json data
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              
                              options:kNilOptions
                              error:&error];
        
        //The results from Google will be an array obtained from the NSDictionary object with the key "results".
        NSArray* places = [json objectForKey:@"results"];
//        NSLog(@"Places count: %i",[places count]);
//        NSLog(@"First Object:\nname: %@ \nlat: %@ \nlng: %@", [[places objectAtIndex:0] objectForKey:@"name"] , [[[[places objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"], [[[[places objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"]);
        self.arrAnnotation = [[NSMutableArray alloc]init];
        for (int i = 0; i < [places count]; i++) {
            Object *obj = [[Object alloc]init];
            [obj setLat:[[[[places objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"]];
            [obj setLng:[[[[places objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"]];
            [obj setLocationName:[[places objectAtIndex:i] objectForKey:@"name"]];
            CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake([[obj lat] doubleValue], [[obj lng] doubleValue]);
            MyAnnotation *annotation = [[MyAnnotation alloc] init];
            annotation.coordinate = annotationCoordinate;
            annotation.title = obj.locationName;
//            annotation.subtitle = @"";
            NSLog(@"title: %@",obj.locationName);
            [self.arrAnnotation addObject:annotation];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            [self.mapView addAnnotations:self.arrAnnotation];
        });
        //Write out the data to the console.
        //    NSLog(@"Google Data: %@", places);
    });
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
        NSLog(@"did add annotation views");
//    MKCoordinateRegion region;
//    region = MKCoordinateRegionMakeWithDistance(locationManger.location.coordinate, 2000, 2000);
//    [mapView setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0){
        NSLog(@"did update user location");
    if(!self.userLocationUpdated){
        [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        self.userLocationUpdated = YES;
//        mapView.showsUserLocation = NO;
    }
//    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.1f, 0.1f)) animated:YES];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKAnnotationView *view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"annoView"];
    if (!view) {
        view = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annoView"];
    }
    view.image = [UIImage imageNamed:@"pin.png"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    view.leftCalloutAccessoryView = iconView;
    
    view.canShowCallout = YES;
    return view;
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
