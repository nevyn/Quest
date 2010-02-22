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
	QSTResTexture *texture = [textures objectForKey:name];
	if(texture != nil) return texture;
	
	NSBitmapImageRep *img = [NSBitmapImageRep imageRepWithContentsOfFile:name];
	
	printf("Bpp: %d", [img bitsPerPixel]);
	
	unsigned char *data = [img bitmapData];
	
	texture = [[QSTResTexture alloc] init];
	[textures setValue:texture forKey:name];
	[texture release];
	return texture;
}

+(QSTResSprite*)getSpriteWithName:(NSString*)name {
	QSTResSprite *sprite = [sprites objectForKey:name];
	if(sprite != nil) return sprite;
	
	
	sprite = [[QSTResSprite alloc] init];
	[sprites setObject:sprite forKey:name];
	[sprite release];
	
	return sprite;
}

@end
