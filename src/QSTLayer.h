//
//  QSTLayer.h
//  Quest
//
//  Created by Per Borgman on 2010-03-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Vector2;
@class MutableVector2;
@class QSTEntity;
@class QSTTerrain;

@interface QSTLayer : NSObject {
	// Depth affects how much the layers scrolls when the camera
	// moves, and how much it zooms.
	float			depth;
	
	// This is how fast the layer continuously scrolls, regardless
	// of camera movement.
	Vector2			*autoScrollSpeed;
	
	// Layers can be tiled. Needed when layer auto scrolls,
	// but can be used to tile a static but small layer too.
	BOOL			repeatX, repeatY;
	
	MutableVector2	*currentPosition;
	Vector2			*startPosition;	
	
	NSMutableArray	*entities;
	
	QSTTerrain		*terrain;
}

-(void)registerEntity:(QSTEntity*)entity;
-(void)addEntity:(QSTEntity*)entity;		// Dangerous, no checking
-(void)setTerrain:(QSTTerrain*)tTerrain;
-(void)render;
-(void)renderEntities;
-(void)renderTerrain;

@end
