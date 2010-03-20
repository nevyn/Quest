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

static NSString *QSTStartInModeKey = @"startmode";
typedef enum { // These map to the indices in the boot dialog
	QSTStartSingleplayer,
	QSTStartHostingStandalone,
	QSTStartJoiningStandalone,
	QSTStartJoiningMaster,
	
	QSTStartModeCount
} QSTStartMode;
static NSString *QSTStartModeNames[] = {@"single", @"host", @"join", @"master"};

static NSString *QSTStartWithGameKey = @"game";
static NSString *QSTStartJoiningHostKey = @"host";
static NSString *QSTFirstBootKey = @"QSTFirstBoot";

@implementation QuestAppDelegate
+(void)initialize;
{
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
		[NSNumber numberWithInt:QSTStartSingleplayer], QSTStartInModeKey,
		(id)kCFBooleanTrue, QSTFirstBootKey,
		nil
	]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	// Parse argv
	
	void (^usage)() = ^ {
		printf(
			"Usage: Quest.app/Contents/MacOS/Quest [args]\n"
			" --startmode {single|host|join|master}\n"
			" --game [path to a game folder]\n"
			" --host [hostname] (if --startmode join)\n"
			" --help"
		);
		[NSApp terminate:nil];
	};

	typedef struct {
		NSString *arg;
		BOOL takesValue;
		void (^action)(NSString *arg, NSString *value);
	} Action;
	Action actions[] = {
	
		QSTStartInModeKey, YES, ^ (NSString *arg, NSString *value) {
			for(int i = 0; i < QSTStartModeCount; i++)
				if([value isEqual:QSTStartModeNames[i]]) {
					[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:i] forKey:QSTStartInModeKey];
					return;
				}
			usage();
		},
		QSTStartWithGameKey, YES, ^(NSString *k, NSString *v){
			// NSUserDefaults doesn't support URLs; encode it so we can still use bindings in UI
			NSData *encodedURL = [NSArchiver archivedDataWithRootObject:[NSURL fileURLWithPath:v]];
			[[NSUserDefaults standardUserDefaults] setObject:encodedURL forKey:k];
		},
		QSTStartJoiningHostKey, YES, ^(NSString *k, NSString *v){
			[[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
		},
		@"help", NO, ^(NSString*k, NSString*v) { usage(); }
		
	};
	
	// Loop through the arguments, matching them to the actions array, performing the action
	// if the name and argument count matches; otherwise prints usage()
	NSArray *argv = [[NSProcessInfo processInfo] arguments];
	for(int i = 0; i < argv.count; i++) {
		NSString *arg = [argv objectAtIndex:i];

		for(int j = 0; j < sizeof(actions)/sizeof(Action); j++) {
			if([arg isEqual:[@"--" stringByAppendingString:actions[j].arg]]) {
			
				NSString *val = nil;
				if(actions[j].takesValue)
					if(i+1 < argv.count)
						val = [argv objectAtIndex:++i];
					else usage();
					
				actions[j].action(actions[j].arg, val);
				break;
			}
		}
		
	}
	
	// Boot dialog
	
	if(
		[[NSUserDefaults standardUserDefaults] boolForKey:QSTFirstBootKey] ||
		[NSEvent  modifierFlags] & NSAlternateKeyMask ||
		![[NSUserDefaults standardUserDefaults] objectForKey:QSTStartWithGameKey]
	) {
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:QSTFirstBootKey];
		[modeSelection makeKeyAndOrderFront:nil];
	} else {
		[gameWindow makeKeyAndOrderFront:nil];
		[self start:nil];
	}	
}

-(IBAction)start:(id)sender;
{
	printf("Create core.");
	NSData *encodedGamePath = [[NSUserDefaults standardUserDefaults] objectForKey:QSTStartWithGameKey];
	NSString *gamePath = encodedGamePath ? [[NSUnarchiver unarchiveObjectWithData:encodedGamePath] absoluteString] : nil;
	core = [[QSTCore alloc] init];
	
	//[view setCore:core];
	[view start];
}
@end
