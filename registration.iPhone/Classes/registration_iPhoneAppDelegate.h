//
//  registration_iPhoneAppDelegate.h
//  registration.iPhone
//
//  Created by Jesus Fernandez on 8/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

@interface registration_iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

