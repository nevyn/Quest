//
//  QSTResSprite.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResSprite.h"

#import "JSON.h"
#import "Vector2.h"
#import "QSTBoundingBox.h"
#import "QSTResourceDB.h"
#import "QSTResTextureAnimation.h"

@implementation QSTResSprite

//@synthesize center;
//@synthesize size;
@synthesize	canvas;

-(id)initWithName:(NSString*)name {
	if(self = [super init]) {
		NSString *spritePath = [NSString stringWithFormat:@"testgame/sprites/%@/", name];
		NSString *defpath = [NSString stringWithFormat:@"%@sprite.def", spritePath];
		NSString *rawData = [NSString stringWithContentsOfFile:defpath encoding:NSUTF8StringEncoding error:NULL];

		SBJsonParser *parser = [[SBJsonParser alloc] init];
		NSMutableDictionary *r_root = [parser objectWithString:rawData];
		NSMutableDictionary *r_data = [r_root objectForKey:@"data"];
		NSMutableArray *r_data_size = [r_data objectForKey:@"size"];
		NSMutableArray *r_data_center = [r_data objectForKey:@"center"];
		
		int sx = [[r_data_size objectAtIndex:0] intValue];
		int sy = [[r_data_size objectAtIndex:1] intValue];
		
		int cx = [[r_data_center objectAtIndex:0] intValue];
		int cy = [[r_data_center objectAtIndex:1] intValue];
		
		Vector2 *min = [[MutableVector2 vectorWithX:-cx y:-cy] divideWithScalar:64.0f];
		Vector2 *max = [[MutableVector2 vectorWithX:sx - cx y:sy - cy] divideWithScalar:64.0f];
		
		canvas = [[QSTBoundingBox bboxWithMin:min max:max] retain];
		
		
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

-(void)useWithAnimation:(NSString*)animName frame:(int)frame {
	[[animations objectForKey:animName] useWithFrame:frame];
}

-(QSTBoundingBox*)texCoordsForAnimation:(NSString*)animName frame:(int)frame {
	return [((QSTResTextureAnimation*)[animations objectForKey:animName]).subdivs objectAtIndex:frame];
}

@end
