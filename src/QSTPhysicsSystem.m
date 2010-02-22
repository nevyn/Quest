//
//  QSTPhysicsSystem.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTPhysicsSystem.h"

#import "QSTCmpPhysics.h"
#import "QSTCmpPosition.h"
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

-(void)tick:(float)dt {
	return;
	for(QSTCmpPhysics *ph in components) {
		ph.velocity.y += 0.1f * dt;
		ph.position.position.y += ph.velocity.y;
	}
}

@end
