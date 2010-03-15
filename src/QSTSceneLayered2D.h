//
//  QSTSceneLayered2D.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
 
	Layered 2D scene
 
	A 2D scene, divided into one or more layers.
	Layers can be scrolled separately (parallax). Entities can
	be added to any layer, and then follow the layer's settings.
  
*/

@class MutableVector2;
@class Vector2;
@class QSTEntity;

@interface QSTLayer2D : NSObject {
	// Depth affects how much the layers scrolls when the camera
	// moves, and how much it zooms.
	float			depth;
		
	// This is how fast the layer continuously scrolls, regardless
	// of camera movement.
	CGPoint			autoScrollSpeed;
	
	// Layers can be tiled. Needed when layer auto scrolls,
	// but can be used to tile a static but small layer too.
	BOOL			repeatX, repeatY;
	
	MutableVector2	*currentPosition;
	Vector2			*startPosition;	
	
	NSMutableArray	*entities;
}

-(void)addEntity:(QSTEntity*)entity;
-(void)render;

@end


@interface QSTSceneLayered2D : NSObject {
	NSMutableArray	*layers;
}

-(id)init;
-(void)addEntity:(QSTEntity*)entity toLayer:(int)layer;
-(void)render;

@end
