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
#import "QSTCore.h"

@implementation QSTResSprite

//@synthesize center;
//@synthesize size;
@synthesize bbox;
@synthesize	canvas;

+(QSTResSprite*)spriteWithPath:(NSURL*)spritePath resources:(QSTResourceDB*)resourceDB {
	NSURL *defpath = $joinUrls(spritePath, @"sprite.def");
	NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONURL:defpath];
	if(!r_root) return nil;
	return [[[QSTResSprite alloc] initWithData:(NSMutableDictionary*)r_root path:spritePath resources:resourceDB] autorelease];
}

-(id)initWithData:(NSMutableDictionary*)spriteData path:(NSURL*)path resources:(QSTResourceDB*)resourceDB
{
	if(![super init]) return nil;
		
	NSMutableDictionary *r_data = [spriteData objectForKey:@"data"];
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
		
	NSMutableDictionary *r_animations = [spriteData objectForKey:@"animations"];
	
	animations = [[NSMutableDictionary dictionary] retain];
	
	for(NSString* animName in r_animations) {
		QSTResTextureAnimation *anim = [[QSTResTextureAnimation alloc]
										initWithData:[r_animations objectForKey:animName] path:path resources:resourceDB];
		[animations setObject:anim forKey:animName];
		[anim release];
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
