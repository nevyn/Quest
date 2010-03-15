//
//  QSTResourceDB.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResourceDB.h"

#import "JSON.h"
#import "QSTResTexture.h"
#import "QSTResSprite.h"
//#import "QSTResEntityTemplate.h"

static NSMutableDictionary *textures;
static NSMutableDictionary *sprites;
//static NSMutableDictionary *entityTemplates;

@implementation QSTResourceDB

+(void)initialize {
	textures = [[NSMutableDictionary alloc] init];
	sprites = [[NSMutableDictionary alloc] init];
	//entityTemplates = [[NSMutableDictionary alloc] init];
}

+(QSTResTexture*)getTextureWithPath:(NSString*)path {
	printf("ResourceDB: getTextureWithPath [%s]\n", [path UTF8String]);
	
	QSTResTexture *texture = [textures objectForKey:path];
	if(texture != nil) { printf("Already loaded.\n"); return texture; }
	
	NSString *fullPath = [NSString stringWithFormat:@"%@.png", path];
	NSBitmapImageRep *img = [NSBitmapImageRep imageRepWithContentsOfFile:fullPath];
		
	unsigned char *data = [img bitmapData];
	int	width = [img pixelsWide];
	int height = [img pixelsHigh];
	BOOL hasAlpha = [img hasAlpha];
			
	texture = [[QSTResTexture alloc] initWithData:data width:width height:height hasAlpha:hasAlpha];
	[textures setObject:texture forKey:path];
	[texture release];
	return texture;
}

+(QSTResSprite*)getSpriteWithName:(NSString*)name {
	printf("ResourceDB: getSpriteWithName [%s]\n", [name UTF8String]);
	
	QSTResSprite *sprite = [sprites objectForKey:name];
	if(sprite != nil) { printf("Already loaded.\n"); return sprite; }
		
	sprite = [[QSTResSprite alloc] initWithName:name];
	[sprites setObject:sprite forKey:name];
	[sprite release];
	
	return sprite;
}

/*
+(QSTResEntityTemplate*)getEntityTemplateWithName:(NSString*)name {
	printf("ResourceDB: getEntityTemplateWithName [%s]\n", [name UTF8String]);
	
	QSTResEntityTemplate *entTem = [entityTemplates objectForKey:name];
	if(entTem != nil) { printf("Already loaded.\n"); return entTem; }
	
	entTem = [[QSTResEntityTemplate alloc] initWithName:name];
	[entityTemplates setObject:entTem forKey:name];
	[entTem release];
	
	return entTem;
}
 */

@end
