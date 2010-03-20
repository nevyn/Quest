//
//  GraphicsSystem.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTGraphicsSystem.h"

#import <OpenGL/OpenGL.h>

#import "QSTSceneLayered2D.h"
#import "QSTCmpCollisionMap.h"
#import "QSTEntity.h"


/*typedef struct {
} QSTBatchSettings;


@implementation QSTBatch

-(void)render: {
	for(QSTComponent *aComponent in components) {
		aComponent.
	}
}

@end*/


@implementation QSTGraphicsSystem

-(id)init {
	if(self = [super init]) {		
		pixelToUnitRatio = 64;
		
		glViewport(0, 0, 640, 480);		
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(0., 10.0f, 7.5f, 0., -1., 1.);	
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		
		glDisable(GL_DEPTH_TEST);
		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_FASTEST);
		glDisable(GL_CULL_FACE);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		
		glEnable(GL_TEXTURE_2D);
		glPointSize(5.0f);
		
		layers = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)clear {
	[layers release];
	layers = [[NSMutableArray alloc] init];
}

-(void)tick {
	[self beginFrame];
	
	// Render world and entities
	for(QSTLayer *aLayer in layers)
		[aLayer render];
		
	// GUI
}

-(void)beginFrame {
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity();
}

-(void)addLayer:(QSTLayer*)theLayer {
	[layers addObject:theLayer];
}

/*
-(void)registerEntity:(QSTEntity*)entity inLayer:(int)layer {
	if([entity property:@"SpriteName"] == nil) return;
	[[layers objectAtIndex:layer] addEntity:entity];
}

-(void)setTerrain:(QSTTerrain *)tTerrain forLayer:(int)layer {
	[[layers objectAtIndex:layer] setTerrain:tTerrain];
}
*/

@end
