//
//  QSTView.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTView.h"

#import "QSTCore.h"

@implementation QSTView

-(void)setCore:(QSTCore*)theCore {
	core = theCore;
}

-(void)start {
	printf("Starting timer...\n");
	
	loopTimer = [[NSTimer scheduledTimerWithTimeInterval:0.0166f target:self selector:@selector(generateTick:) userInfo:nil repeats:YES] retain];
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

@end
