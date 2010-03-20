//
//  QuestAppDelegate.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuestAppDelegate.h"

#import "QSTCore.h"
#import "QSTView.h"

@implementation QuestAppDelegate

@synthesize view;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	printf("Create core.\n");
	core = [[QSTCore alloc] init];
	
	//[view setCore:core];
	[view start];
}

@end
