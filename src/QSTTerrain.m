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

#import "QSTLog.h"

@interface QSTTerrainTile ()
@property (nonatomic, retain) QSTResSprite *sprite;
@property (nonatomic, retain) NSString *currentAnimation;
@property (nonatomic, retain) Vector2 *position;
@end


@implementation QSTTerrainTile
@synthesize sprite, currentAnimation, position;

-(id)initWithPosition:(Vector2*)thePos rotation:(float)theRot scale:(float)theScale sprite:(QSTResSprite*)sprite_ animation:(NSString*)animName {
	if(![super init]) return nil;
	
	currentFrame = 0.0f;
	self.currentAnimation = animName;
	
	self.position = [Vector2 vectorWithVector2:thePos];
	scale = theScale;
	rotation = theRot;
	
	sprite = sprite_;

	return self;
}
-(void)dealloc;
{
	self.sprite = nil;
	self.currentAnimation = nil;
	self.position = nil;
	[super dealloc];
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

@interface QSTTerrain ()
@property (nonatomic, retain) NSMutableArray	*tiles;
@end


@implementation QSTTerrain
@synthesize tiles;

+(QSTTerrain*)terrainWithData:(NSMutableArray*)terrainData resources:(QSTResourceDB*)resourceDB;
 {
	return [[[QSTTerrain alloc] initWithTerrainData:terrainData resources:resourceDB] autorelease];
}


-(id)initWithTerrainData:(NSMutableArray*)terrainData resources:(QSTResourceDB*)resourceDB;
{
	if(![super init]) return nil;
	tiles = [[NSMutableArray alloc] init];
	
	for(NSMutableDictionary *tileData in terrainData) {
		Vector2 *position = [JSONHelper vectorFromKey:@"position" data:tileData];
		float rotation = [[tileData objectForKey:@"rotation"] floatValue];
		float scale = [[tileData objectForKey:@"scale"] floatValue];
		QSTResSprite *sprite = [resourceDB getSpriteWithName:[tileData objectForKey:@"sprite"]];
		NSString *animName = [tileData objectForKey:@"animation"];
		
		QSTTerrainTile *tile = [[[QSTTerrainTile alloc] initWithPosition:position
																rotation:rotation
																   scale:scale
																  sprite:sprite
															   animation:animName] autorelease];
		
		[tiles addObject:tile];
	}
		
	return self;
}


-(void)dealloc;
{
	self.tiles = nil;
	[super dealloc];
}


-(void)render {
	for(QSTTerrainTile *tile in tiles) {
		[tile render];
	}
}

@end
