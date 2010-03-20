//
//  QSTTerrain.h
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTResSprite;
@class QSTResourceDB;
@class Vector2;

@interface QSTTerrainTile : NSObject {
	QSTResSprite	*sprite;
	NSString		*currentAnimation;
	float			currentFrame;
	
	Vector2			*position;
	float			scale;
	float			rotation;
}

-(id)initWithPosition:(Vector2*)thePos rotation:(float)theRot scale:(float)theScale sprite:(QSTResSprite*)sprite animation:(NSString*)animName;
-(void)render;

@end

@interface QSTTerrain : NSObject {
	// TODO: put into quadtree (or just a uniform grid) for speed-up
	// Also, sort by texture.
	NSMutableArray	*tiles;
}

+(QSTTerrain*)terrainWithData:(NSMutableArray*)terrainData resources:(QSTResourceDB*)resourceDB;

-(id)initWithTerrainData:(NSMutableArray*)terrainData resources:(QSTResourceDB*)resourceDB;
				   
-(void)render;

@end
