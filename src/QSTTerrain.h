//
//  QSTTerrain.h
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTResSprite;
@class Vector2;

@interface QSTTerrainTile : NSObject {
	QSTResSprite	*sprite;
	NSString		*currentAnimation;
	float			currentFrame;
	
	Vector2			*position;
	float			scale;
	float			rotation;
}

-(id)initWithPosition:(Vector2*)thePos rotation:(float)theRot scale:(float)theScale sprite:(NSString*)spriteName;
-(void)render;

@end

@interface QSTTerrain : NSObject {
	// TODO: put into quadtree (or just a uniform grid) for speed-up
	// Also, sort by texture.
	NSMutableArray	*tiles;
}

-(id)init;

-(void)render;

@end
