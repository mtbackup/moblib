//
//  registration_iPhoneAppDelegate.m
//  registration.iPhone
//
//  Created by Jesus Fernandez on 8/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "registration_iPhoneAppDelegate.h"
#import "RootViewController.h"


@implementation registration_iPhoneAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

