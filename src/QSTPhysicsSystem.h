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

@class QSTCmpPhysics;
@class QSTCmpCollisionMap;
@class QSTBoundingBox;
@class QSTLine;
@class Vector2;

@interface QSTPhysicsSystem : NSObject {

	NSMutableArray	*components;
	QSTCmpCollisionMap	*collisionMap;
	
}

-(id)init;
-(void)addComponent:(QSTCmpPhysics*)aComponent toLayer:(int)theLayer;
-(void)setCollisionMap:(QSTCmpCollisionMap*)aColMap forLayer:(int)theLayer;
-(void)tick:(float)dt;

-(Vector2*)collideBBox:(QSTBoundingBox*)bbox withLine:(QSTLine*)line from:(Vector2*)from to:(Vector2*)to;
-(Vector2*)collideBBox:(QSTBoundingBox*)bbox withBBox:(QSTBoundingBox*)other atPosition:(Vector2*)pos from:(Vector2*)from to:(Vector2*)to;

@end
