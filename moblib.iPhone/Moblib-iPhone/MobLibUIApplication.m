//
//  MobLibUIApplication.m
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

#import "MobLibUIApplication.h"
#import "MobLibFeedbackViewController.h"

@implementation MobLibUIApplication

- (void)sendEvent:(UIEvent *)anEvent
{
#define GS_EVENT_TYPE_OFFSET 2
#define GS_EVENT_X_OFFSET 6
#define GS_EVENT_Y_OFFSET 7
#define STATUS_BAR_TOUCH_DOWN 1015
    
    // Traverse from the UIEvent to the GSEvent to the type
    int *eventMemory = (int *)[anEvent performSelector:@selector(_gsEvent)];
    int eventType = eventMemory[GS_EVENT_TYPE_OFFSET];
	
    // Look for status bar touches by event type
    if (eventType == STATUS_BAR_TOUCH_DOWN)
    {
        // The next 6 lines aren't essential but if you want to know where the
		// touch coordinates live, here they are: 
        int xMemory = eventMemory[GS_EVENT_X_OFFSET];
        int yMemory = eventMemory[GS_EVENT_Y_OFFSET];
		
        typedef union {int intValue; float floatValue;} Int2Float;
        float x = ((Int2Float)xMemory).floatValue;
        float y = ((Int2Float)yMemory).floatValue;
		
        NSLog(@"Status bar down at %f, %f", x, y);
		[(NSObject <UIApplicationDelegate, MobLibUIApplicationDelegate> *)self.delegate statusBarTouched];
		
    }
    else
    {
        [super sendEvent:anEvent];
    }
}

@end
