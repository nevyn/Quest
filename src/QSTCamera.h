//
//  QSTCamera.h
//  Quest
//
//  Created by Per Borgman on 2010-03-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Vector2;
@class MutableVector2;
@class QSTEntity;

@interface QSTCamera : NSObject {
	//QSTGraphicsSystem	*gfxSystem;
	
	MutableVector2	*position;
	
	float			maxx, maxy;
	
	BOOL			followMode;
	QSTEntity		*entityToFollow;
	
	// When not in follow mode, use this as destination instead:
	MutableVector2	*destination;
	
	float			speed;
	float			zoomFactor;
	float			goalZoomFactor;
	float			zoomSpeed;
	
	// YES while in the midst of zooming in or out. Used
	// so that the camera doesn't always call the GFX system's
	// zoom functions.
	BOOL			zooming;
}

@property (nonatomic,readonly) Vector2 *position;
@property (nonatomic,readonly) float zoomFactor;

-(id)init;
//-(id)initWithGraphicsSystem:(QSTGraphicsSystem*)gfx;
-(void)setWidth:(int)w height:(int)h;
-(void)update:(float)delta;

-(void)zoomTo:(float)theZoom withSpeed:(float)theSpeed;
-(void)panToX:(float)x y:(float)y withSpeed:(float)theSpeed;
-(void)follow:(QSTEntity*)follow withSpeed:(float)theSpeed;

@end
