//
//  QSTView.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTView.h"

#import "QSTCore.h"
#import "QSTInputSystem.h"

@implementation QSTView

-(void)awakeFromNib {
	// Hinder drawRect until core is created.
	[self setNeedsDisplay:NO];
}

-(void)setCore:(QSTCore*)theCore {
	core = theCore;
}

-(void)start {
	printf("Starting timer...\n");
	
	float interval = 1.0f / 60.0f;
	loopTimer = [[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(generateTick:) userInfo:nil repeats:YES] retain];
	
	printf("Started.\n");
}

-(void)generateTick:(NSTimer*)theTimer {
	[self setNeedsDisplay:YES];
}

-(BOOL)acceptsFirstResponder {
	return YES;
}

- (void)drawRect:(NSRect)rect {
	[core tick];
	[[self openGLContext] flushBuffer];
}

-(void)keyDown:(NSEvent *)theEvent {
	[core.inputSystem pressedKey:[theEvent keyCode] repeated:[theEvent isARepeat]];
}

-(void)keyUp:(NSEvent *)theEvent {
	[core.inputSystem releasedKey:[theEvent keyCode]];
}

-(void)flagsChanged:(NSEvent *)theEvent {
}

@end
