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
#import "QSTProperty.h"
#import "QSTLayer.h"

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

@implementation QSTCamera

@synthesize position;

-(id)initWithGraphicsSystem:(QSTGraphicsSystem*)gfx {
	if(![super init]) return nil;
	
	gfxSystem = gfx;	
	
	position = [[MutableVector2 vector] retain];
	destination	= [[MutableVector2 vector] retain];
	zoomFactor = 1.0f;
	
	return self;
}

-(void)update:(float)delta {
	if(followMode) {
		QSTProperty *pos = [entityToFollow property:@"Position"];
		position.x = [pos vectorVal].x;
		position.y = [pos vectorVal].y;
		
		if(position.x < 5.0f) position.x = 5.0f;
		else if(position.x >= maxx) position.x = maxx;
		
		if(position.y < 3.75f) position.y = 3.75f;
		else if(position.y >= maxy) position.y = maxy;
	}
}

-(void)zoomTo:(float)theZoom withSpeed:(float)theSpeed {
	goalZoomFactor = theZoom;
	zoomSpeed = theSpeed;
	zooming = YES;
}

-(void)panToX:(float)x y:(float)y withSpeed:(float)theSpeed {
	followMode = NO;
	destination.x = x;
	destination.y = y;
	speed = theSpeed;
}

-(void)follow:(QSTEntity*)follow withSpeed:(float)theSpeed {
	if(entityToFollow != follow) [entityToFollow release];
	printf("Camera: Follow entity: %d (%s)\n", follow.EID, [follow.type UTF8String]);
	entityToFollow = [follow retain];
	followMode = YES;
	speed = theSpeed;
	
	QSTProperty *layProp = [follow property:@"Layer"];
	QSTLayer *layer = [gfxSystem layer:[layProp intVal]];
	maxx = layer.width * 10.0f - 5.0f;
	maxy = layer.height * 7.5f - 3.75f;
	
	printf("Layer: %d\n", [layProp intVal]);
	printf("layer.width: %d\n", layer.width);
}

@end


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
		camera = [[QSTCamera alloc] initWithGraphicsSystem:self];
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
		[aLayer renderWithCameraPosition:camera.position];
	}
		
	// GUI
}

-(void)beginFrame {
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity();
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
