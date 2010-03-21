//
//  QSTPhysicsSystem.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
	
	Physics system
 
	Also works in batches, since only entities
	within the same layer collides with each other.
 
*/

typedef enum {
	QSTCmpPhysicsTypePhysics,
	QSTCmpPhysicsTypeCollisionMap
} QSTCmpPhysicsType;

@class QSTCmpCollisionMap;
@class QSTBoundingBox;
@class QSTLine;
@class Vector2;
@class QSTEntity;
@class QSTCore;

@interface QSTPhysicsLayer : NSObject {
	NSMutableArray		*entities;
	QSTCmpCollisionMap	*collisionMap;
}
-(id)init;
-(void)addEntity:(QSTEntity*)entity;
@end

@interface QSTPhysicsSystem : NSObject {
	NSMutableArray		*layers;
	QSTCore *core;
}

-(id)initOnCore:(QSTCore*)core_;
-(void)loadLayerWithData:(NSMutableDictionary*)data index:(int)index;
-(void)registerEntity:(QSTEntity*)entity inLayer:(int)layer;
-(void)tick:(float)dt;

//-(QSTTraceResult*)traceBBox:(QSTBoundingBox*)bbox from:(Vector2*)from to:(Vector2*)to;

-(Vector2*)collideBBox:(QSTBoundingBox*)bbox withLine:(QSTLine*)line from:(Vector2*)from to:(Vector2*)to;
-(Vector2*)collideBBox:(QSTBoundingBox*)bbox withBBox:(QSTBoundingBox*)other atPosition:(Vector2*)pos from:(Vector2*)from to:(Vector2*)to;

@end
