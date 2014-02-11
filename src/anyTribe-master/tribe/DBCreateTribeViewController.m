//
//  DBCreateTribeViewController.m
//  tribe
//
//  Created by Jack on 07/02/2014.
//  Copyright (c) 2014 Parse. All rights reserved.
//

#import "DBCreateTribeViewController.h"

@interface DBCreateTribeViewController ()

@end

@implementation DBCreateTribeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.font = [UIFont systemFontOfSize:15];
	textField.placeholder = @"enter text";
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.keyboardType = UIKeyboardTypeDefault;
	textField.returnKeyType = UIReturnKeyDone;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textField.delegate = self;
	[self.view addSubview:textField];
//	[textField release];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
