//
//  QSTCore.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCore.h"

#import "Vector2.h"
#import "QSTGraphicsSystem.h"
#import "QSTPhysicsSystem.h"
#import "QSTCmpPosition.h"
#import "QSTCmpSprite.h"
#import "QSTCmpPhysics.h"
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
		QSTCmpPosition *pos = [[QSTCmpPosition alloc] initWithEID:0];
		pos.position.x = 4.0f;
		pos.position.y = 7.0f;
		QSTCmpSprite *gfx = [[QSTCmpSprite alloc] initWithEID:0 name:@"lasse" position:pos];
		QSTCmpPhysics *ph = [[QSTCmpPhysics alloc] initWithEID:0 position:pos];
		
		[graphicsSystem.scene addComponent:gfx toLayer:0];
		[physicsSystem addComponent:ph toLayer:0];
		
		[pos release];
		[gfx release];
		[ph release];
		/*
		pos = [[QSTCmpPosition alloc] initWithEID:1];
		pos.position.x = 10.0f;
		pos.position.y = 7.0f;
		gfx = [[QSTCmpSprite alloc] initWithEID:1 name:@"64x64" position:pos];
		ph = [[QSTCmpPhysics alloc] initWithEID:1 position:pos];
		
		[graphicsSystem.scene addComponent:gfx toLayer:0];
		[physicsSystem addComponent:ph toLayer:0];
		
		[pos release];
		[gfx release];
		[ph release];
		
		pos = [[QSTCmpPosition alloc] initWithEID:2];
		pos.position.x = 16.0f;
		pos.position.y = 7.0f;
		gfx = [[QSTCmpSprite alloc] initWithEID:2 name:@"lasse" position:pos];
		ph = [[QSTCmpPhysics alloc] initWithEID:2 position:pos];
		
		[graphicsSystem.scene addComponent:gfx toLayer:0];
		[physicsSystem addComponent:ph toLayer:0];
		
		[pos release];
		[gfx release];
		[ph release];
		 */
	}
	return self;
}

-(void)tick {
	
	float delta = 0.0166f;

	[physicsSystem tick:delta];
	[graphicsSystem tick];
}

@end
