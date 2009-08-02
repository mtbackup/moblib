//
//  moblib_iPhoneAppDelegate.m
//  moblib.iPhone
//
//  Created by Jesus Fernandez on 8/1/09.
//  Copyright Jesus Fernandez 2009. All rights reserved.
//

#import "moblib_iPhoneAppDelegate.h"
#import "MainViewController.h"
#import "MobLibFeedbackViewController.h"

@implementation moblib_iPhoneAppDelegate


@synthesize window;
@synthesize mainViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {

	//improve performance for demo by having the controller in memory
	[MobLibFeedbackViewController sharedFeedbackController];
	
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
	[MobLibFeedbackViewController finalize];
}

- (void)applicationWillTerminate:(UIApplication *)application{
	[MobLibFeedbackViewController finalize];
}

#pragma mark MobLibUIApplicationDelegate
- (void)statusBarTouched{
	[[MobLibFeedbackViewController sharedFeedbackController] present];
}


- (void)dealloc {
    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
