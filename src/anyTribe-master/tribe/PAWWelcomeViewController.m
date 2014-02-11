//
//  PAWViewController.m
//  Anywall
//
//  Created by Christopher Bowns on 1/30/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "PAWWelcomeViewController.h"
#import <Parse/Parse.h>

#import "PAWAppDelegate.h"
#import "PAWWallViewController.h"
#import "PAWLoginViewController.h"
#import "PAWNewUserViewController.h"

@implementation PAWWelcomeViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


// Set up login with facebook button.
- (void)viewDidLoad {
	FBLoginView *loginView = [[FBLoginView alloc] init];
	loginView.readPermissions = @[@"basic_info"];
	
	// Align the button in the center horizontally
	loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 100);
	[self.view addSubview:loginView];
}

// Go to map view if the user has successfully logged into FB.
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
	PAWWallViewController *wallViewController = [[PAWWallViewController alloc] initWithNibName:nil bundle:nil];
	[(UINavigationController *)self.presentingViewController pushViewController:wallViewController animated:NO];
//	[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
//		// Tear down the activity view in all cases.
//		[activityView.activityIndicator stopAnimating];
//		[activityView removeFromSuperview];
//		
//		if (user) {
//			PAWWallViewController *wallViewController = [[PAWWallViewController alloc] initWithNibName:nil bundle:nil];
//			[(UINavigationController *)self.presentingViewController pushViewController:wallViewController animated:NO];
//			//			PAWWallPostsTableViewController *wallViewController = [[PAWWallPostsTableViewController alloc] initWithNibName:nil bundle:nil];
//			//			[(UINavigationController *)self.presentingViewController pushViewController:wallViewController animated:NO];
//			[self.presentingViewController dismissModalViewControllerAnimated:YES];
//		} else {
//			// Didn't get a user.
//			NSLog(@"%s didn't get a user!", __PRETTY_FUNCTION__);
//			
//			// Re-enable the done button if we're tossing them back into the form.
//			doneButton.enabled = [self shouldEnableDoneButton];
//			UIAlertView *alertView = nil;
//			
//			if (error == nil) {
//				// the username or password is probably wrong.
//				alertView = [[UIAlertView alloc] initWithTitle:@"Couldn’t log in:\nThe username or password were wrong." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//			} else {
//				// Something else went horribly wrong:
//				alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//			}
//			[alertView show];
//			// Bring the keyboard back up, because they'll probably need to change something.
//			[usernameField becomeFirstResponder];
//		}
//	}];
}

#pragma mark - Transition methods

- (IBAction)loginButtonSelected:(id)sender {
	PAWLoginViewController *loginViewController = [[PAWLoginViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController presentViewController:loginViewController animated:YES completion:^{}];
}

- (IBAction)createButtonSelected:(id)sender {
	PAWNewUserViewController *newUserViewController = [[PAWNewUserViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController presentViewController:newUserViewController animated:YES completion:^{}];
}

//- (IBAction)gotoParse:(id)sender {
//	UIApplication *ourApplication = [UIApplication sharedApplication];
//    NSURL *url = [NSURL URLWithString:@"https://www.parse.com/"];
//    [ourApplication openURL:url];
//}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
