//
//  QSTResSprite.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResSprite.h"

#import "JSONHelper.h"
#import "Vector2.h"
#import "QSTBoundingBox.h"
#import "QSTResourceDB.h"
#import "QSTResTextureAnimation.h"

@implementation QSTResSprite

//@synthesize center;
//@synthesize size;
@synthesize bbox;
@synthesize	canvas;

-(id)initWithName:(NSString*)name {
	if(self = [super init]) {
		NSString *spritePath = [NSString stringWithFormat:@"testgame/sprites/%@/", name];
		NSString *defpath = [NSString stringWithFormat:@"%@sprite.def", spritePath];

		NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONPath:defpath];
		
		NSMutableDictionary *r_data = [r_root objectForKey:@"data"];
		NSMutableArray *r_data_size = [r_data objectForKey:@"size"];
		NSMutableArray *r_data_center = [r_data objectForKey:@"center"];
		NSMutableArray *r_data_colbox = [r_data objectForKey:@"colbox"];
		
		int sx = [[r_data_size objectAtIndex:0] intValue];
		int sy = [[r_data_size objectAtIndex:1] intValue];
		
		int cx = [[r_data_center objectAtIndex:0] intValue];
		int cy = [[r_data_center objectAtIndex:1] intValue];
		
		int cbx = [[r_data_colbox objectAtIndex:0] intValue];
		int cby = [[r_data_colbox objectAtIndex:1] intValue];
				
		Vector2 *min = [[MutableVector2 vectorWithX:-cx y:-cy] divideWithScalar:64.0f];
		Vector2 *max = [[MutableVector2 vectorWithX:sx - cx y:sy - cy] divideWithScalar:64.0f];
		
		canvas = [[QSTBoundingBox bboxWithMin:min max:max] retain];
		
		min = [[MutableVector2 vectorWithX:-cx y:-cy] divideWithScalar:64.0f];
		max = [[MutableVector2 vectorWithX:cbx - cx y:cby - cy] divideWithScalar:64.0f];
		
		bbox = [[QSTBoundingBox bboxWithMin:min max:max] retain];
		
		/*
		printf("Canvas: %s\n", [[canvas repr] UTF8String]);
		printf("BBox: %s\n", [[bbox repr] UTF8String]);
		*/
		
		NSMutableDictionary *r_animations = [r_root objectForKey:@"animations"];
		
		animations = [[NSMutableDictionary dictionary] retain];
		
		for(NSString* animName in r_animations) {
			QSTResTextureAnimation *anim = [[QSTResTextureAnimation alloc]
											initWithData:[r_animations objectForKey:animName] path:spritePath];
			[animations setObject:anim forKey:animName];
			[anim release];
		}
		
		printf("Sprite %s, animations:\n", [name UTF8String]);
		for(NSString *a in animations)
			printf("  %s\n", [a UTF8String]);
	}
	return self;
}

-(int)maxFramesForAnimation:(NSString*)animName {
	return ((QSTResTextureAnimation*)[animations objectForKey:animName]).maxFrames;
}

-(QSTBoundingBox*)useWithAnimation:(NSString*)animName frame:(int)frame {
	return [[animations objectForKey:animName] useWithFrame:frame];
}

@end
