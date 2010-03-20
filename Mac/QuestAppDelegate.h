//
//  QuestAppDelegate.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTCore;
@class QSTView;

@interface QuestAppDelegate : NSObject <NSApplicationDelegate> {
	QSTCore		*core;
	
	IBOutlet QSTView		*view;
	IBOutlet NSWindow *gameWindow;
	IBOutlet NSWindow *modeSelection;
}
-(IBAction)start:(id)sender;
@end
