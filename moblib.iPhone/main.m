//
//  main.m
//  moblib.iPhone
//
//  Created by Jesus Fernandez on 8/1/09.
//  Copyright Jesus Fernandez 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	//Use custom MobLibUIApplication class to capture status bar events in
	//the adhoc appliation. Use conditionals to use UIApplication in
	//release builds
#ifdef DEBUG
	int retVal = UIApplicationMain(argc, argv, @"MobLibUIApplication", nil);
#else
	int retVal = UIApplicationMain(argc, argv, nil, nil);
#endif
	
    [pool release];
    return retVal;
}
