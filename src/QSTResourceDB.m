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
#import "QSTCore.h"
//#import "QSTResEntityTemplate.h"

@interface QSTResourceDB ()
@property (assign) QSTCore *core;
@property (retain) NSMutableDictionary *textures;
@property (retain) NSMutableDictionary *sprites;
@end


@implementation QSTResourceDB
@synthesize core, textures, sprites;

-(id)initOnCore:(QSTCore*)core_;
{
	if(![super init]) return nil;
	
	self.core = core_;
	textures = [[NSMutableDictionary alloc] init];
	sprites = [[NSMutableDictionary alloc] init];
	//entityTemplates = [[NSMutableDictionary alloc] init];
	
	return self;
}
-(void)dealloc;
{
	self.textures = self.sprites = nil;
	self.core = nil;
	[super dealloc];
}

-(QSTResTexture*)getTextureWithPath:(NSURL*)path {
	printf("ResourceDB: getTextureWithPath [%s]\n", [[path path] UTF8String]);
	
	QSTResTexture *texture = [textures objectForKey:path];
	if(texture != nil) { printf("Already loaded.\n"); return texture; }
	
	NSURL *fullPath = [path URLByAppendingPathExtension:@"png"];
	NSBitmapImageRep *img = [NSBitmapImageRep imageRepWithContentsOfURL:fullPath];
		
	unsigned char *data = [img bitmapData];
	int	width = [img pixelsWide];
	int height = [img pixelsHigh];
	BOOL hasAlpha = [img hasAlpha];
			
	texture = [[QSTResTexture alloc] initWithData:data width:width height:height hasAlpha:hasAlpha];
	[textures setObject:texture forKey:path];
	[texture release];
	return texture;
}

-(QSTResSprite*)getSpriteWithName:(NSString*)name {
	//printf("ResourceDB: getSpriteWithName [%s]\n", [name UTF8String]);
	
	QSTResSprite *sprite = [sprites objectForKey:name];
	if(sprite != nil) { /*printf("Already loaded.\n");*/ return sprite; }
	
	NSURL *spritePath = $joinUrls(core.gamePath, @"sprites", name);
	sprite = [[(QSTResSprite*)[QSTResSprite alloc] initWithPath:spritePath resources:self] autorelease];
	[sprites setObject:sprite forKey:name];
	
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
