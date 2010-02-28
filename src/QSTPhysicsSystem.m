//
//  QSTPhysicsSystem.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTPhysicsSystem.h"

#import "QSTCmpPhysicsBase.h"
#import "QSTCmpPhysics.h"
#import "QSTCmpPosition.h"
#import "QSTCmpCollisionMap.h"
#import "QSTLine.h"
#import "Vector2.h"

@implementation QSTPhysicsSystem

-(id)init {
	if (self = [super init]) {
		components = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)addComponent:(QSTCmpPhysics*)aComponent toLayer:(int)theLayer {
	[components addObject:aComponent];
}

-(void)setCollisionMap:(QSTCmpCollisionMap*)aColMap forLayer:(int)theLayer {
	collisionMap = [aColMap retain];
}

-(void)tick:(float)dt {
	for(int i=0; i<[components count]; i++) {
		QSTCmpPhysics *ph1 = [components objectAtIndex:i];
		
		ph1.velocity.y += 0.1f * dt;
		ph1.velocity.x = 0.1f;
				
		MutableVector2 *to = [MutableVector2 vectorWithX:ph1.position.position.x + ph1.velocity.x y:ph1.position.position.y + ph1.velocity.y];
				
		QSTLine *move = [[QSTLine alloc] initWithA:ph1.position.position b:to];
				
		BOOL collided = NO;
		for(QSTLine *l in collisionMap.lines) {
			Vector2 *isct = [move intersects:l];
			if(isct == nil) continue;
			
			collided = YES;
			
			if(l.normal.y > -0.7f) {
				ph1.position.position.x += l.normal.x;
				ph1.position.position.y = isct.y;
				ph1.velocity.y = 0.0f;
			}
			else {
				ph1.position.position.x = isct.x;
				ph1.position.position.y = isct.y;
				ph1.velocity.y = 0.0f;
			}
			
			break;
		}
		
		if(collided == NO) {
			ph1.position.position.x += ph1.velocity.x;
			ph1.position.position.y += ph1.velocity.y;
		}
		
		/*
		for(int j=i+1; j<[components count]; j++) {
			QSTCmpPhysics *ph2 = [components objectAtIndex:j];
			
		}
		 */
	}
}

@end
