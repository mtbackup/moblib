//
//  moblib_iPhoneAppDelegate.h
//  moblib.iPhone
//
//  Created by Jesus Fernandez on 8/1/09.
//  Copyright Jesus Fernandez 2009. All rights reserved.
//

#import "MobLibUIApplication.h"
@class MainViewController;

@interface moblib_iPhoneAppDelegate : NSObject <UIApplicationDelegate, MobLibUIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end

