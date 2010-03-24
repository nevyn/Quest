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

#import "QSTLog.h"

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
	
	Info(@"Engine", @"-------- Initializing Resource DB --------");
	
	self.core = core_;
	textures = [[NSMutableDictionary alloc] init];
	sprites = [[NSMutableDictionary alloc] init];
	
	return self;
}
-(void)dealloc;
{
	self.textures = self.sprites = nil;
	self.core = nil;
	[super dealloc];
}

-(QSTResTexture*)getTextureWithPath:(NSURL*)path {
	QSTResTexture *texture = [textures objectForKey:path];
	if(texture != nil) { return texture; }
	
	NSURL *fullPath = [path URLByAppendingPathExtension:@"png"];
	NSBitmapImageRep *img = [NSBitmapImageRep imageRepWithContentsOfURL:fullPath];
	
	if(!img) {
		Error(@"Engine", @"ResourceDB: Texture not found: '%@'", [fullPath relativeString]);
		// TODO: Return a generated error texture
		return nil;
	}
		
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
	QSTResSprite *sprite = [sprites objectForKey:name];
	if(sprite != nil) { return sprite; }
	
	NSURL *spritePath = $joinUrls(core.gamePath, @"sprites", name);
  	sprite = [QSTResSprite spriteWithPath:spritePath resources:self];
	if(!sprite) {
		Error(@"Engine", @"ResourceDB: Sprite not found: '%s'", [[spritePath relativeString] UTF8String]);
		return nil;
	}
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
