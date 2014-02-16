//
//  PAWAppDelegate.m
//  Anywall
//
//  Created by Christopher Bowns on 1/30/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

static NSString * const defaultsFilterDistanceKey = @"filterDistance";
static NSString * const defaultsLocationKey = @"currentLocation";

#import "PAWAppDelegate.h"

#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>

#import "PAWWelcomeViewController.h"
#import "PAWWallViewController.h"
#import "PAWWallPostsTableViewController.h"

@interface PAWAppDelegate ()


@end

@implementation PAWAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize filterDistance;
@synthesize currentLocation;


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	
	// ****************************************************************************
    // Parse initialization
    [Parse setApplicationId:@"ledWVi7au9ulx2VAkcNKphrbKApBbTcnCGBGxaMj" clientKey:@"fXeaehyE9nNHieEeq34A6k6e5rYo4fUwi9NR7nTz"];
	// ****************************************************************************
	
	// ****************************************************************************
    // GoogleMaps initialization
	[GMSServices provideAPIKey:@"AIzaSyCNHIhNGaygDGF8zlQVTAasImApTMS2yqc"];
	// ****************************************************************************

	
	// Grab values from NSUserDefaults:
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	// Set the global tint on the navigation bar
	[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:200.0f/255.0f green:83.0f/255.0f blue:70.0f/255.0f alpha:1.0f]];
//	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
	
	// Desired search radius:
	if ([userDefaults doubleForKey:defaultsFilterDistanceKey]) {
		// use the ivar instead of self.accuracy to avoid an unnecessary write to NAND on launch.
		filterDistance = [userDefaults doubleForKey:defaultsFilterDistanceKey];
	} else {
		// if we have no accuracy in defaults, set it to 1000 feet.
		self.filterDistance = 1000 * kPAWFeetToMeters;
	}

	UINavigationController *navController = nil;

	if ([PFUser currentUser]) {
		// Skip straight to the main view.
		PAWWallViewController *wallViewController = [[PAWWallViewController alloc] initWithNibName:nil bundle:nil];
		navController = [[UINavigationController alloc] initWithRootViewController:wallViewController];
		navController.navigationBarHidden = YES;
//		PAWWallPostsTableViewController *wallViewController = [[PAWWallPostsTableViewController alloc] initWithNibName:nil bundle:nil];
//		navController = [[UINavigationController alloc] initWithRootViewController:wallViewController];
//		navController.navigationBarHidden = NO;
		self.viewController = navController;
		self.window.rootViewController = self.viewController;
	} else {
		// Go to the welcome screen and have them log in or create an account.
		[self presentWelcomeViewController];
	}
	
	[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
	
    [self.window makeKeyAndVisible];
    return YES;
}

// FACEBOOK override. Handles responses from FB app.
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
	
	// Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
	BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
	
	// You can add your app-specific url handling code here if needed
	
	return wasHandled;
}

#pragma mark - PAWAppDelegate

- (void)setFilterDistance:(CLLocationAccuracy)aFilterDistance {
	filterDistance = aFilterDistance;

	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setDouble:filterDistance forKey:defaultsFilterDistanceKey];
	[userDefaults synchronize];

	// Notify the app of the filterDistance change:
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:filterDistance] forKey:kPAWFilterDistanceKey];
	dispatch_async(dispatch_get_main_queue(), ^{
		[[NSNotificationCenter defaultCenter] postNotificationName:kPAWFilterDistanceChangeNotification object:nil userInfo:userInfo];
	});
}

- (void)setCurrentLocation:(CLLocation *)aCurrentLocation {
	currentLocation = aCurrentLocation;

	// Notify the app of the location change:
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:currentLocation forKey:kPAWLocationKey];
	dispatch_async(dispatch_get_main_queue(), ^{
		[[NSNotificationCenter defaultCenter] postNotificationName:kPAWLocationChangeNotification object:nil userInfo:userInfo];
	});
}

- (void)presentWelcomeViewController {
	// Go to the welcome screen and have them log in or create an account.
	PAWWelcomeViewController *welcomeViewController = [[PAWWelcomeViewController alloc] initWithNibName:@"PAWWelcomeViewController" bundle:nil];
	welcomeViewController.title = @"Welcome to Tribe";
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:welcomeViewController];
	navController.navigationBarHidden = YES;

	self.viewController = navController;
	self.window.rootViewController = self.viewController;
}

@end
