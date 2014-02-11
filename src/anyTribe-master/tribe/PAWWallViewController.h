//
//  PAWWallViewController.h
//  Anywall
//
//  Created by Christopher Bowns on 1/30/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import "PAWPost.h"

@interface PAWWallViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate> {
	UISearchBar *theSearchBar;
	GMSMapView *mapView_;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UISearchBar *theSearchBar;


@end

@protocol PAWWallViewControllerHighlight <NSObject>

- (void)highlightCellForPost:(PAWPost *)post;
- (void)unhighlightCellForPost:(PAWPost *)post;

@end
