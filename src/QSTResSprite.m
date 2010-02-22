//
//  QSTResSprite.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResSprite.h"

#import "Vector2.h"
#import "QSTBoundingBox.h"
#import "QSTResourceDB.h"

@implementation QSTResSprite

@synthesize center;
@synthesize size;
@synthesize	frame;

-(id)initWithTexture:(NSString*)tex {
	if(self = [super init]) {
		texture = [QSTResourceDB getTextureWithName:tex];
				
		if([tex isEqualToString:@"testgame/sprites/32x32.png"])
			size = [[Vector2 vectorWithScalar:1.0f] retain];
		else if([tex isEqualToString:@"testgame/sprites/64x64.png"])
			size = [[Vector2 vectorWithScalar:2.0f] retain];
		else
			size = [[Vector2 vectorWithX:5.0f y:5.0f] retain];
		
		center = [[Vector2 vectorWithScalar:size.x/2.0f] retain]; // vectorWithX:1.0f y:1.75f] retain];

		
		frame = [[QSTBoundingBox bboxWithMinX:-size.x/2.0f minY:-size.y/2.0f maxX:size.x/2.0f maxY:size.y/2.0f] retain];
	}
	return self;
}

-(void)use {
	[texture use];
}

@end
