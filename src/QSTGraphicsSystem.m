//
//  GraphicsSystem.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTGraphicsSystem.h"

#import <OpenGL/OpenGL.h>

#import "QSTCamera.h"
#import "QSTLayer.h"

#import "QSTCmpCollisionMap.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

#import "Vector2.h"


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

@synthesize camera;

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
		camera = [[QSTCamera alloc] init];
	}
	return self;
}

-(void)clear {
	[layers removeAllObjects];
}

-(void)tick:(float)delta {
	[self beginFrame];
	
	[camera update:delta];
	
	// Render world and entities
	for(QSTLayer *aLayer in layers) {
		[aLayer renderWithCamera:camera];
	}
			
	// GUI
}

-(void)beginFrame {
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity();
}

-(void)newSceneWithWidth:(int)w height:(int)h {
	[layers removeAllObjects];
	[camera setWidth:w height:h];
}

-(void)addLayer:(QSTLayer*)theLayer {
	[layers addObject:theLayer];
}

-(QSTLayer*)layer:(int)layerIndex {
	return [layers objectAtIndex:layerIndex];
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
