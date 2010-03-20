//
//  QSTTerrain.m
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTTerrain.h"

#import "JSONHelper.h"

#import "QSTResourceDB.h"
#import "QSTResSprite.h"

#import "QSTBoundingBox.h"
#import "Vector2.h"

@implementation QSTTerrainTile

-(id)initWithPosition:(Vector2*)thePos rotation:(float)theRot scale:(float)theScale sprite:(NSString*)spriteName animation:(NSString*)animName {
	if(self = [super init]) {
		currentFrame = 0.0f;
		currentAnimation = [animName retain];
		
		position = [[Vector2 vectorWithVector2:thePos] retain];
		scale = theScale;
		rotation = theRot;
		
		sprite = [[QSTResourceDB getSpriteWithName:spriteName] retain];
		
		printf("Tile: %f %f, %f degrees, %f scale, %s, %s\n", position.x, position.y, rotation, scale, [spriteName UTF8String], [animName UTF8String]);
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
	
	Vector2 *min = sprite.canvas.min;
	Vector2 *max = sprite.canvas.max;
		
	glPushMatrix();
	
	glTranslatef(position.x, position.y, 0.0f);
	glRotatef(rotation, 0.0f, 0.0f, 1.0f);
	glScalef(scale, scale, 0.0f);
	
	glColor3f(1.0f, 1.0f, 1.0f);
	
	glBegin(GL_QUADS);
	glTexCoord2f(tex.min.x, tex.min.y);
	glVertex2f(min.x, min.y);
	
	glTexCoord2f(tex.max.x, tex.min.y);
	glVertex2f(max.x, min.y);
	
	glTexCoord2f(tex.max.x, tex.max.y);
	glVertex2f(max.x, max.y);
	
	glTexCoord2f(tex.min.x, tex.max.y);
	glVertex2f(min.x, max.y);
	glEnd();
	
	glPopMatrix();
	
	currentFrame += 0.2f;
	if(currentFrame >= [sprite maxFramesForAnimation:currentAnimation]) currentFrame = 0.0f;
}

@end


@implementation QSTTerrain

+(QSTTerrain*)terrainWithData:(NSMutableArray*)terrainData {
	return [[[QSTTerrain alloc] initWithTerrainData:terrainData] autorelease];
}

-(id)initWithTerrainData:(NSMutableArray*)terrainData {
	if(self = [super init]) {
		tiles = [[NSMutableArray alloc] init];
		
		for(NSMutableDictionary *tileData in terrainData) {
			Vector2 *position = [JSONHelper vectorFromKey:@"position" data:tileData];
			float rotation = [[tileData objectForKey:@"rotation"] floatValue];
			float scale = [[tileData objectForKey:@"scale"] floatValue];
			NSString *spriteName = [tileData objectForKey:@"sprite"];
			NSString *animName = [tileData objectForKey:@"animation"];
			
			QSTTerrainTile *tile = [[QSTTerrainTile alloc] initWithPosition:position 
																   rotation:rotation 
																	  scale:scale 
																	 sprite:spriteName 
																  animation:animName];
			
			[tiles addObject:tile];
		}
	}
	return self;
}

-(void)render {
	for(QSTTerrainTile *tile in tiles) {
		[tile render];
	}
}

@end
