//
//  QSTCore.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCore.h"

#import "QSTGraphicsSystem.h"
#import "QSTPhysicsSystem.h"
#import "QSTCmpSprite.h"
#import "QSTSceneLayered2D.h"

@implementation QSTCore

-(id)init {
	if(self = [super init]) {
		// Create systems
		graphicsSystem = [[QSTGraphicsSystem alloc] init];
		physicsSystem = [[QSTPhysicsSystem alloc] init];
						   
		
		// Creating an entity
		// Entity is composed of a physical aspect and a
		// graphical one.
		QSTCmpSprite *gfx = [[QSTCmpSprite alloc] initWithEID:0];
		//QSTCmpPhysics *ph = [[QSTCmpPhysics alloc] initWithEID:0];
		
		[graphicsSystem.scene addComponent:gfx toLayer:0];
		//[physicsSystem addComponent:ph toLayer:0];
		
		[gfx release];
		//[ph release];
	}
	return self;
}

-(void)tick {
	[graphicsSystem tick];
}

@end
