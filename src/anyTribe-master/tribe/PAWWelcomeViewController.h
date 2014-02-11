//
//  PAWViewController.h
//  Anywall
//
//  Created by Christopher Bowns on 1/30/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <UIKit/UIKit.h>

@interface PAWWelcomeViewController : UIViewController<FBLoginViewDelegate>

- (IBAction)loginButtonSelected:(id)sender;
- (IBAction)createButtonSelected:(id)sender;
//- (IBAction)gotoParse:(id)sender;

@end
