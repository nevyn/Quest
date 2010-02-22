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
	
	printf("ResourceDB: getTextureWithName [%s]\n", [name UTF8String]);
	
	NSBitmapImageRep *img = [NSBitmapImageRep imageRepWithContentsOfFile:name];
		
	unsigned char *data = [img bitmapData];
	int	width = [img pixelsWide];
	int height = [img pixelsHigh];
	
	printf("%d %d\n", width, height);
		
	texture = [[QSTResTexture alloc] initWithData:data width:width height:height];
	[textures setValue:texture forKey:name];
	[texture release];
	return texture;
}

+(QSTResSprite*)getSpriteWithName:(NSString*)name {
	QSTResSprite *sprite = [sprites objectForKey:name];
	if(sprite != nil) return sprite;
	
	printf("ResourceDB: getSpriteWithName [%s]\n", [name UTF8String]);
	
	
	
	sprite = [[QSTResSprite alloc] initWithTexture:name];
	[sprites setObject:sprite forKey:name];
	[sprite release];
	
	return sprite;
}

@end
