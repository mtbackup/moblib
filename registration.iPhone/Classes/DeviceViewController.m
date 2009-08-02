//
//  DeviceViewController.m
//  registration.iPhone
//
//  Created by Jesus Fernandez on 8/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DeviceViewController.h"


@implementation DeviceViewController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	//Find out as much about the device as possible!
	UIDevice *currentDevice = [UIDevice currentDevice];
	
	// Create a dictionary
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setValue:[currentDevice name] forKey:@"Name"];
	[dictionary setValue:[currentDevice model] forKey:@"Model"];
	[dictionary setValue:[currentDevice systemName] forKey:@"System Name"];
	[dictionary setValue:[currentDevice systemVersion] forKey:@"System Version"];
	//[dictionary setValue:[currentDevice uniqueIdentifier] forKey:@"UUID"];
	
	data = [dictionary retain];
	rows = [[dictionary allKeys] retain];
	
}
 
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	NSString *result = @"";
	switch (section) {
		case 0:
			result = @"Device Information";
			break;
		default:
			result = @"User Information";
			break;
	}
	
	return result;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rows count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = (NSString *)[rows objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = (NSString *)[data valueForKey:cell.textLabel.text];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)dealloc {
    [super dealloc];
}


@end

