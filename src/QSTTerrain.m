//
//  QSTTerrain.m
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTTerrain.h"

#import "QSTResourceDB.h"
#import "QSTResSprite.h"

#import "QSTBoundingBox.h"
#import "Vector2.h"

@implementation QSTTerrainTile

-(id)initWithPosition:(Vector2*)thePos rotation:(float)theRot scale:(float)theScale sprite:(NSString*)spriteName {
	if(self = [super init]) {
		currentFrame = 0.0f;
		currentAnimation = [@"idle" retain];
		
		position = [[Vector2 vectorWithVector2:thePos] retain];
		scale = theScale;
		rotation = theRot;
		
		sprite = [[QSTResourceDB getSpriteWithName:spriteName] retain];
	}
	return self;
}

-(void)render {
	
	// TODO: Maybe implement it with offsets, so that we don't
	// need all the translation...
	// On the other hand we need to hard-save the coordinates if we
	// do that since we can't rotate... oh wait we can.
	// Would be nice to not need to push/pop the matrix
	
	QSTBoundingBox *tex = [sprite useWithAnimation:currentAnimation frame:currentFrame];
		
	glPushMatrix();
	
	glTranslatef(position.x, position.y, 0.0f);
	glRotatef(rotation, 0.0f, 0.0f, 1.0f);
	glScalef(scale, scale, 0.0f);
	
	glColor3f(1.0f, 1.0f, 1.0f);
	
	glBegin(GL_QUADS);
	glTexCoord2f(tex.min.x, tex.min.y);
	glVertex2f(-0.5f, -0.5f);
	glTexCoord2f(tex.max.x, tex.min.y);
	glVertex2f(0.5f, -0.5f);
	glTexCoord2f(tex.max.x, tex.max.y);
	glVertex2f(0.5f, 0.5f);
	glTexCoord2f(tex.min.x, tex.max.y);
	glVertex2f(-0.5f, 0.5f);
	glEnd();
	
	glPopMatrix();
	
	currentFrame += 0.2f;
	if(currentFrame >= [sprite maxFramesForAnimation:currentAnimation]) currentFrame = 0.0f;
}

@end


@implementation QSTTerrain

-(id)init {
	if(self = [super init]) {
		QSTTerrainTile *t1 = [[QSTTerrainTile alloc] initWithPosition:[Vector2 vectorWithX:3.0f y:7.0f]
															 rotation:20.0f
																scale:5.0f
															   sprite:@"lasse"];
		QSTTerrainTile *t2 = [[QSTTerrainTile alloc] initWithPosition:[Vector2 vectorWithX:7.0f y:6.0f]
															 rotation:85.0f
																scale:1.2f
															   sprite:@"lasse"];

		tiles = [[NSMutableArray alloc] init];
		[tiles addObject:t1];
		[tiles addObject:t2];
		
		[t1 release];
		[t2 release];
	}
	return self;
}

-(void)render {
	for(QSTTerrainTile *tile in tiles) {
		[tile render];
	}
}

@end
