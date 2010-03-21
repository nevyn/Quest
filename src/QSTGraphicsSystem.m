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

@synthesize position, zoomFactor;

-(id)initWithGraphicsSystem:(QSTGraphicsSystem*)gfx {
	if(![super init]) return nil;
	
	gfxSystem = gfx;	
	
	position = [[MutableVector2 vector] retain];
	destination	= [[MutableVector2 vector] retain];
	zoomFactor = 1.0f;
	
	[self setWidth:1 height:1];
	
	return self;
}

-(void)setWidth:(int)w height:(int)h {
	maxx = w * 10.0f;
	maxy = h * 7.5f;
}

-(void)update:(float)delta {
	if(followMode) {
		QSTProperty *pos = [entityToFollow property:@"Position"];
		position.x = [pos vectorVal].x;
		position.y = [pos vectorVal].y;
	}
	
	if(zooming) {				
		if(zoomFactor < goalZoomFactor)
			zoomFactor += zoomSpeed * delta;
		else {
			zoomFactor -= zoomSpeed * delta;
		}		
	}
	
	MutableVector2 *min = [MutableVector2 vector];
	MutableVector2 *max = [MutableVector2 vector];
	
	float size_x = 10.0f / zoomFactor;
	float size_y = 7.5f / zoomFactor;
	
	if(size_x > maxx) {
		zoomFactor = 10.0f / maxx;
		size_x = maxx;
		size_y = 7.5f / zoomFactor;
	}
	if(size_y > maxy) {
		zoomFactor = 7.5f / maxy;
		size_y = maxy;
		size_x = 10.0f / zoomFactor;
	}
	
	min.x = max.x = position.x;
	min.y = max.y = position.y;
	
	min.x -= (size_x / 2.0f);
	min.y -= (size_y / 2.0f);
	max.x += (size_x / 2.0f);
	max.y += (size_y / 2.0f);
	
	if(min.x < 0.0f) {
		min.x = 0.0f;
		max.x = size_x;
	} else if (max.x > maxx) {
		max.x = maxx;
		min.x = maxx - size_x;
	}
	if(min.y < 0.0f) {
		min.y = 0.0f;
		max.y = size_y;
	} else if(max.y > maxy) {
		max.y = maxy;
		min.y = maxy - size_y;
	}
	
	position.x = (min.x + max.x) / 2.0f;
	position.y = (min.y + max.y) / 2.0f;
	
	
	
	//printf("Camera: %f %f => %f %f\n", min.x, min.y, max.x, max.y);
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
