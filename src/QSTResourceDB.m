//
//  QSTResourceDB.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResourceDB.h"

#import "QSTResTexture.h"
#import "QSTResSprite.h"

static NSMutableDictionary *textures;
static NSMutableDictionary *sprites;

@implementation QSTResourceDB

+(void)initialize {
	textures = [[NSMutableDictionary alloc] init];
	sprites = [[NSMutableDictionary alloc] init];
}

+(QSTResTexture*)getTextureWithName:(NSString*)name {
	printf("ResourceDB: getTextureWithName [%s]\n", [name UTF8String]);
	
	QSTResTexture *texture = [textures objectForKey:name];
	if(texture != nil) { printf("Already loaded.\n"); return texture; }
	
	
	NSBitmapImageRep *img = [NSBitmapImageRep imageRepWithContentsOfFile:name];
		
	unsigned char *data = [img bitmapData];
	int	width = [img pixelsWide];
	int height = [img pixelsHigh];
			
	texture = [[QSTResTexture alloc] initWithData:data width:width height:height];
	[textures setObject:texture forKey:name];
	[texture release];
	return texture;
}

+(QSTResSprite*)getSpriteWithName:(NSString*)name {
	printf("ResourceDB: getSpriteWithName [%s]\n", [name UTF8String]);
	
	QSTResSprite *sprite = [sprites objectForKey:name];
	if(sprite != nil) { printf("Already loaded.\n"); return sprite; }
	
	
	
	
	sprite = [[QSTResSprite alloc] initWithTexture:name];
	[sprites setObject:sprite forKey:name];
	[sprite release];
	
	return sprite;
}

@end
