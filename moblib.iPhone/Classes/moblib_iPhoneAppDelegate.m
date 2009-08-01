//
//  moblib_iPhoneAppDelegate.m
//  moblib.iPhone
//
//  Created by Jesus Fernandez on 8/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "moblib_iPhoneAppDelegate.h"
#import "MainViewController.h"

@implementation moblib_iPhoneAppDelegate


@synthesize window;
@synthesize mainViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
