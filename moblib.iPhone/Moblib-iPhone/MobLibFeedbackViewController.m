//
//  MobLibFeedbackViewController.m
//  moblib.iPhone
//
//  Created by Jesus Fernandez on 8/1/09.
//  Copyright 2009 Jesus Fernandez. 
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

#import "MobLibFeedbackViewController.h"
#import "MobLibFeedbackRequest.h"

static MobLibFeedbackViewController *sharedInstance = NULL;

@implementation MobLibFeedbackViewController

+ (id)sharedFeedbackController {
	@synchronized(self){
		if(sharedInstance == NULL){
			sharedInstance = [[MobLibFeedbackViewController alloc] initWithNibName:@"MobLibFeedbackViewController" bundle:nil];
		}
	}
	
	return sharedInstance;
}

+ (void)finalize {
	[sharedInstance release];
	sharedInstance = NULL;
}

@synthesize screenshotView;
@synthesize textView;
@synthesize cancelButton;
@synthesize doneButton;
@synthesize activityView;
@synthesize presenting;

- (void)dealloc {
	[screenshotView release];
	[textView release];
	[cancelButton release];
	[doneButton release];
	[activityView release];
    [super dealloc];
}

- (void)present{	
	if(!self.presenting){
		self.presenting = YES;
		CGRect finalFrame = [[UIScreen mainScreen] applicationFrame];
		CGRect initialFrame = finalFrame;
		initialFrame.origin.y = finalFrame.size.height;
		self.view.frame = initialFrame;
		
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		[window addSubview:self.view];
		
		[UIView beginAnimations:nil context:nil];
		[self.view setFrame:finalFrame];
		[UIView commitAnimations];
		
		UIImage *screenshot = [UIImage imageWithCGImage:UIGetScreenImage()];
		[self.screenshotView setImage:screenshot];
		
		self.cancelButton.enabled = YES;
		self.doneButton.enabled = YES;
		self.textView.editable = YES;
		[self.activityView stopAnimating];
		
		self.textView.text = @""; 
		[self.textView becomeFirstResponder];
	}
}

- (void)dismiss{
	CGRect finalFrame = [[UIScreen mainScreen] applicationFrame];
	CGRect initialFrame = finalFrame;
	initialFrame.origin.y = finalFrame.size.height;
	self.view.frame = finalFrame;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneDismissing)];
	[self.view setFrame:initialFrame];
	[UIView commitAnimations];
	
	self.presenting = NO;
}

- (void)doneDismissing{
	[self.view removeFromSuperview];
}

- (IBAction)touchedCancel:(id)sender{
	[self dismiss];
}

- (IBAction)touchedDone:(id)sender{
	self.cancelButton.enabled = NO;
	self.doneButton.enabled = NO;
	self.textView.editable = NO;
	[self.activityView startAnimating];
	
	MobLibFeedbackRequest *request = [[MobLibFeedbackRequest alloc] init]; [request setDelegate:self];
	[request sendResponse:self.textView.text withScreenShot:self.screenshotView.image];
}

-(void)mobLibFeedbackRequestSuccess{
	[self dismiss];
}

-(void)mobLibFeedbackRequestFailed{
	[self dismiss];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@":(" message:@"i broke" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
	[alertView show];
	[alertView release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
