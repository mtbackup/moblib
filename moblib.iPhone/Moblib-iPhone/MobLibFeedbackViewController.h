//
//  MobLibFeedbackViewController.h
//  moblib.iPhone
//
//  Created by Jesus Fernandez on 8/1/09.
//  Copyright 2009 __MyCompanyName__. 
//	Permission is hereby granted, free of charge, to any person
//	obtaining a copy of this software and associated documentation
//	files (the "Software"), to deal in the Software without
//	restriction, including without limitation the rights to use,
//	copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following
//	conditions:
//
//	The above copyright notice and this permission notice shall be
//	included in all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//	OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "MobLibFeedbackRequest.h"

@interface MobLibFeedbackViewController : UIViewController<MobLibFeedbackRequestDelegate> {
	IBOutlet UIImageView *screenshotView;
	IBOutlet UITextView *textView;
	IBOutlet UIBarButtonItem *doneButton;
	IBOutlet UIBarButtonItem *cancelButton;
	IBOutlet UIActivityIndicatorView *activityView;
	
	BOOL presenting;
}

+ (id)sharedFeedbackController;

@property (nonatomic, retain) UIImageView *screenshotView;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *cancelButton;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;

@property (assign) BOOL presenting;

- (void)present;
- (void)dismiss;
- (IBAction)touchedCancel:(id)sender;
- (IBAction)touchedDone:(id)sender;

@end
