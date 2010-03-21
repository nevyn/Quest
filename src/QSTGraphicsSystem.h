//
//  GraphicsSystem.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTEntity;
@class QSTTerrain;
@class QSTLayer;
@class Vector2;
@class MutableVector2;

/*@interface QSTBatch {
	QSTBatchSettings	settings;
	NSArray				*components;
}
@end*/

@class QSTGraphicsSystem;

@interface QSTCamera : NSObject {
	QSTGraphicsSystem	*gfxSystem;
	
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

-(id)initWithGraphicsSystem:(QSTGraphicsSystem*)gfx;

-(void)update:(float)delta;

-(void)zoomTo:(float)theZoom withSpeed:(float)theSpeed;
-(void)panToX:(float)x y:(float)y withSpeed:(float)theSpeed;
-(void)follow:(QSTEntity*)follow withSpeed:(float)theSpeed;

@end


@interface QSTGraphicsSystem : NSObject {
	QSTCamera			*camera;
	NSMutableArray		*layers;
		
	int	pixelToUnitRatio;	// Pixels per unit at normal zoom
}

@property (nonatomic,readonly) QSTCamera *camera;

-(id)init;
-(void)tick:(float)delta;
-(void)beginFrame;

-(void)addLayer:(QSTLayer*)theLayer;
-(QSTLayer*)layer:(int)layerIndex;

/*
-(void)registerEntity:(QSTEntity*)entity inLayer:(int)layer;
-(void)setTerrain:(QSTTerrain*)tTerrain forLayer:(int)layer;
*/

@end
