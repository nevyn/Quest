//
//  QSTView.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTCore;

@interface QSTView : NSOpenGLView {
	NSTimer		*loopTimer;
	QSTCore		*core;
}

-(void)setCore:(QSTCore*)theCore;
-(void)start;

-(void)keyDown:(NSEvent *)theEvent;
-(void)keyUp:(NSEvent *)theEvent;
-(void)flagsChanged:(NSEvent *)theEvent;

@end
