//
//  QSTCamera.m
//  Quest
//
//  Created by Per Borgman on 2010-03-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCamera.h"

#import "Vector2.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

@implementation QSTCamera

@synthesize position, zoomFactor;

-(id)init {
	if(![super init]) return nil;

	position = [[MutableVector2 vector] retain];
	destination	= [[MutableVector2 vector] retain];
	zoomFactor = 1.0f;
	
	[self setWidth:1 height:1];
	
	return self;	
}

/*
-(id)initWithGraphicsSystem:(QSTGraphicsSystem*)gfx {
	if(![self init]) return nil;
	gfxSystem = gfx;
	return self;
}
*/
 
-(void)setWidth:(int)w height:(int)h {
	maxx = w * 10.0f;
	maxy = h * 7.5f;
}

-(void)update:(float)delta {
	float dx, dy;
	if(followMode) {
		QSTProperty *pos = [entityToFollow property:@"Position"];
		dx = [pos vectorVal].x - position.x;
		dy = [pos vectorVal].y - position.y;
	} else {
		dx = destination.x - position.x;
		dy = destination.y - position.y;
	}
	position.x += dx * speed * delta;
	position.y += dy * speed * delta;
	
	if(zooming) {
		
		float zd = goalZoomFactor - zoomFactor;
		if(fabs(zd) < 0.2f) zd = 0.2f * (fabs(zd) / zd);
		
		//printf("zd: %f     tot: %f\n", zd, zd*zoomSpeed*delta);
		
		if(fabs(goalZoomFactor - zoomFactor) < 0.02f) {
			zoomFactor = goalZoomFactor;
			zooming = NO;
		} else
			zoomFactor += zd * zoomSpeed * delta;
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
	entityToFollow = [follow retain];
	followMode = YES;
	speed = theSpeed;
}

@end
