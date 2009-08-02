//
//  MobLibFeedbackRequest.m
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

#define HOST_NAME @"173.45.230.55"
#define RESPONSE_API_PATH @"/mobtest/api/responses/add"
#define TEST_ID @"1"

#import "MobLibFeedbackRequest.h"
@interface MobLibFeedbackRequest(Private)
-(void)_bgSendRequest;
@end


@implementation MobLibFeedbackRequest
@synthesize delegate;

-(void)sendResponse:(NSString *)response withScreenShot:(UIImage *)image{
	
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:HOST_NAME path:RESPONSE_API_PATH];
	
	// Create POST request from message, image, username and password
    NSMutableURLRequest *request_ = [[NSMutableURLRequest alloc] initWithURL:url];
    [request_ setHTTPMethod:@"POST"];
	
    // Setup POST body
    NSString *stringBoundary = [NSString stringWithString:@"0x!!SE0TAM0T"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
    [request_ addValue:contentType forHTTPHeaderField:@"Content-Type"];
	
    NSString *stringBoundarySeparator = [NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary];
	
    NSMutableString *postString = [NSMutableString string];
    [postString appendString:@"\r\n"];
    [postString appendString:stringBoundarySeparator];
    [postString appendString: [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uuid\"\r\n\r\n%@", [[UIDevice currentDevice] uniqueIdentifier]]];
    [postString appendString:stringBoundarySeparator];
    [postString appendString: [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"test_id\"\r\n\r\n%@", TEST_ID]];
    [postString appendString:stringBoundarySeparator];
    [postString appendString: [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"description\"\r\n\r\n%@", response]];
    [postString appendString:stringBoundarySeparator];
	
	//create unique name based on random number + time
	NSString *filename = [NSString stringWithFormat:@"%d.m,l%d.jpg",[NSDate timeIntervalSinceReferenceDate],rand()];
    [postString appendString: [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"screenshot\"; filename=\"%@\"\r\n", filename]];
    [postString appendString:@"Content-Type: image/jpg\r\n"]; // data as JPEG
    [postString appendString:@"Content-Transfer-Encoding: binary\r\n\r\n"];
	
    // Setting up the POST request's multipart/form-data body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:UIImageJPEGRepresentation(image, 1.0)]; // Tack on the image data to the end
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
    [request_ setHTTPBody:postBody];
	
	request = request_;
	
	[self performSelectorInBackground:@selector(_bgSendRequest) withObject:nil];
}

- (void)_bgSendRequest{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSURLResponse *response; NSError *error;
	[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];	
	if([(NSHTTPURLResponse *)response statusCode] == 201){
		NSLog(@"succeeding");
		if ([self.delegate respondsToSelector:@selector(mobLibFeedbackRequestSuccess)]){
			NSLog(@"succeeded");
			[self.delegate performSelectorOnMainThread:@selector(mobLibFeedbackRequestSuccess) withObject:self waitUntilDone:NO];;
		}
	} else {
		NSLog(@"failing");
		if ([self.delegate respondsToSelector:@selector(mobLibFeedbackRequestFailed)]){
			NSLog(@"failed");
			[self.delegate performSelectorOnMainThread:@selector(mobLibFeedbackRequestFailed) withObject:self waitUntilDone:NO];
		}
	}
	
	[self release];
	
	[pool release];
}

@end
