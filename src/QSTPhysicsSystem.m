//
//  QSTPhysicsSystem.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTPhysicsSystem.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

#import "QSTResourceDB.h"
#import "QSTCmpCollisionMap.h"
#import "QSTResSprite.h"

#import "QSTBoundingBox.h"
#import "QSTLine.h"
#import "Vector2.h"
#import "QSTCore.h"

@interface QSTPhysicsSystem ()
@property (nonatomic, assign) QSTCore *core;
@end


@implementation QSTPhysicsSystem
@synthesize core;

-(id)initOnCore:(QSTCore*)core_;
{
	if (![super init]) return nil;
	
	self.core = core_;
	entities = [[NSMutableArray alloc] init];
	
	return self;
}
-(void)dealloc;
{
	self.core = nil;
	[entities release]; entities = nil;
	[collisionMap release]; collisionMap = nil;
	[super dealloc];
}

-(void)registerEntity:(QSTEntity*)entity inLayer:(int)layer {
	if([entity property:@"Velocity"] != nil) [entities addObject:entity];
}

-(void)setCollisionMap:(QSTCmpCollisionMap*)aColMap forLayer:(int)theLayer {
	collisionMap = [aColMap retain];
}

-(void)tick:(float)dt {
	for(int i=0; i<[entities count]; i++) {
		QSTEntity *ent1 = [entities objectAtIndex:i];
		
		QSTProperty *pos = [ent1 property:@"Position"];
		QSTProperty *vel = [ent1 property:@"Velocity"];
		QSTResSprite *sprite = [core.resourceDB getSpriteWithName:[ent1 property:@"SpriteName"].stringVal];
		
		vel.vectorVal.y += 9.8f * dt;
				
		MutableVector2 *to = [MutableVector2 vectorWithX:pos.vectorVal.x + (vel.vectorVal.x * dt)
													   y:pos.vectorVal.y + (vel.vectorVal.y * dt)];
		
		if(to.y > 12.5) {
			to.y = 12.5;
			vel.vectorVal.y = 0.0f;
		}
		
		pos.vectorVal.x = to.x;
		pos.vectorVal.y = to.y;
				
		
		
		
		
		/*
		BOOL collided = NO;
		for(QSTLine *l in collisionMap.lines) {
			
			Vector2 *isct = [self collideBBox:sprite.bbox withLine:l from:pos.vectorVal to:to];
			if(isct == nil) continue;
			
			collided = YES;
			
			if(l.normal.y > -0.7f) {
				pos.vectorVal.x += l.normal.x;
				pos.vectorVal.y = isct.y;
				vel.vectorVal.y = 0.0f;
			}
			else {
				pos.vectorVal.x = isct.x;
				pos.vectorVal.y = isct.y;
				vel.vectorVal.y = 0.0f;
			}
			
			break;
		}
		*/
		/*
		for(int j=0; j<[entities count]; j++) {
			if(i == j) continue;
			
			QSTCmpPhysics *ph2 = [components objectAtIndex:j];
						
			Vector2 *isct = [self collideBBox:ph1.sprite.sprite.bbox 
									 withBBox:ph2.sprite.sprite.bbox 
								   atPosition:ph2.position.position 
										 from:ph1.position.position 
										   to:to];
			if(isct == nil) continue;
			
			collided = YES;
			
			ph1.position.position.x = isct.x;
			ph1.position.position.y = isct.y-0.01f;
			ph1.velocity.y = 0.0f;
		}*/
		/*
		if(collided == NO) {
			pos.vectorVal.x = to.x;
			//pos.vectorVal.y = to.y;
		}
		
		pos.vectorVal.x = to.x;
		pos.vectorVal.y = to.y;
		 */
	}
}

-(Vector2*)collideBBox:(QSTBoundingBox*)bbox withLine:(QSTLine*)line from:(Vector2*)from to:(Vector2*)to {
	QSTLine *lines[4] = {nil};
	
	lines[0] = [[QSTLine alloc] initWithX1:from.x + bbox.min.x y1:from.y + bbox.min.y x2:to.x + bbox.min.x y2:to.y + bbox.min.y];
	lines[1] = [[QSTLine alloc] initWithX1:from.x + bbox.max.x y1:from.y + bbox.min.y x2:to.x + bbox.max.x y2:to.y + bbox.min.y];
	lines[2] = [[QSTLine alloc] initWithX1:from.x + bbox.max.x y1:from.y + bbox.max.y x2:to.x + bbox.max.x y2:to.y + bbox.max.y];
	lines[3] = [[QSTLine alloc] initWithX1:from.x + bbox.min.x y1:from.y + bbox.max.y x2:to.x + bbox.min.x y2:to.y + bbox.max.y];
	
	float dist = 100.0f;
	Vector2 *ret = nil;
	for(int i=0; i<4; i++) {
		Vector2 *isct = [lines[i] intersects:line];
		if(isct == nil)
			continue;
		
		Vector2* move = [Vector2 vectorWithX:isct.x - lines[i].a.x y:isct.y - lines[i].a.y];
		float d = [move length];
		if(d < dist) {
			dist = d;
			ret = [Vector2 vectorWithX:from.x + move.x y:from.y + move.y];
		}
	}
	for(int i=0; i<4; i++) [lines[i] release];
	
	return ret;
}

-(Vector2*)collideBBox:(QSTBoundingBox*)bbox withBBox:(QSTBoundingBox*)other atPosition:(Vector2*)pos from:(Vector2*)from to:(Vector2*)to {
	QSTLine *lines[4] = {nil};
	
	lines[0] = [[QSTLine alloc] initWithX1:pos.x + other.min.x y1:pos.y + other.min.y x2:pos.x + other.max.x y2:pos.y + other.min.y];
	lines[1] = [[QSTLine alloc] initWithX1:pos.x + other.max.x y1:pos.y + other.min.y x2:pos.x + other.max.x y2:pos.y + other.max.y];
	lines[2] = [[QSTLine alloc] initWithX1:pos.x + other.max.x y1:pos.y + other.max.y x2:pos.x + other.min.x y2:pos.y + other.max.y];
	lines[3] = [[QSTLine alloc] initWithX1:pos.x + other.min.x y1:pos.y + other.max.y x2:pos.x + other.min.x y2:pos.y + other.min.y];
	
	float dist = 100.0f;
	Vector2 *ret = nil;
	for(int i=0; i<4; i++) {
		Vector2 *isct = [self collideBBox:bbox withLine:lines[i] from:from to:to];
		if(isct == nil) continue;
		
		//Vector2* move = [Vector2 vectorWithX:isct.x - lines[i].a.x y:isct.y - lines[i].a.y];
		float d = [isct length];
		if(d < dist) {
			dist = d;
			ret = [Vector2 vectorWithVector2:isct];
			//ret = [Vector2 vectorWithX:from.x + move.x y:from.y + move.y];
		}
	}
	
	for(int i=0; i<4; i++) [lines[i] release];
	
	return ret;
}

@end
