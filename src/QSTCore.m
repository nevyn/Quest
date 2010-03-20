//
//  QSTCore.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCore.h"

#import "Vector2.h"
#import "QSTLine.h"
#import "JSONHelper.h"

#import "QSTGraphicsSystem.h"
#import "QSTPhysicsSystem.h"
#import "QSTInputSystem.h"

#import "QSTLayer.h"
#import "QSTTerrain.h"
#import "QSTCmpCollisionMap.h"

#import "QSTEntity.h"
#import "QSTResourceDB.h"
#import "QSTPropertyDB.h"

@interface QSTCore ()
@property (nonatomic,readwrite, copy) NSURL *gamePath;
@end


@implementation QSTCore
@synthesize graphicsSystem, physicsSystem, inputSystem;
@synthesize gamePath;

-(id)initWithGame:(NSURL*)gamePath_;
{
	if(![super init]) return nil;
	core = self;
	
	self.gamePath = gamePath_;
	
	graphicsSystem = [[QSTGraphicsSystem alloc] init];
	physicsSystem = [[QSTPhysicsSystem alloc] init];
	inputSystem = [[QSTInputSystem alloc] init];
	
	QSTInputMapper *mapper = [[QSTInputMapper alloc] init];
	[mapper registerActionWithName:@"jump" action:@selector(jump) target:self];
	[mapper registerStateActionWithName:@"left" beginAction:@selector(leftStart) endAction:@selector(leftStop) target:self];
	[mapper registerStateActionWithName:@"right" beginAction:@selector(rightStart) endAction:@selector(rightStop) target:self];
	[mapper mapKey:49 toAction:@"jump"];
	[mapper mapKey:123 toAction:@"left"];
	[mapper mapKey:124 toAction:@"right"];
	inputSystem.mapper = mapper;
	[mapper release];
	
	
	[self loadArea:@"test"];
	return self;
}

// TODO:
// Flytta ut all area-laddningskod härifrån! 
// Kanske ha en Area-klass, eller åtminstone nån loader. AreaLoader?

-(void)loadArea:(NSString*)areaName {
	NSURL *areaPath = [core.gamePath URLByAppendingPathComponents:$array(
		@"areas", $sprintf(@"%@.area", areaName)
	)];
	
	NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONURL:areaPath];
	
	// Later there will be some area-global data here, like
	// music and mood etc
				
	NSMutableArray *r_layers = [r_root objectForKey:@"layers"];
	for(int i=0; i<[r_layers count];i++) {
		[self loadLayer:[r_layers objectAtIndex:i] withIndex:i];
	}
	
	// Create player entity
	// ATTN: or is there always a player entity?
	
}

-(void)loadLayer:(NSMutableDictionary*)layerData withIndex:(int)theIndex {
	
	printf("Load layer %d...\n", theIndex);
	
	/* Graphics */
	QSTLayer *layer = [[QSTLayer alloc] init];
	
	float depth = [[layerData objectForKey:@"depth"] floatValue];
	layer.depth = depth;
	
	NSMutableArray *r_terrain = [layerData objectForKey:@"terrain"];
	QSTTerrain *terrain = [QSTTerrain terrainWithData:r_terrain];
	[layer setTerrain:terrain];
	
	
	/* Physics */
	NSMutableArray *r_colmap = [layerData objectForKey:@"colmap"];
	if(r_colmap != nil) {
		QSTCmpCollisionMap *colmap = [[QSTCmpCollisionMap alloc] initWithEID:0];
		for(NSMutableArray *vec in r_colmap) {
			Vector2 *v1 = [Vector2 vectorWithX:[[vec objectAtIndex:0] floatValue]
											 y:[[vec objectAtIndex:1] floatValue]];
			Vector2 *v2 = [Vector2 vectorWithX:[[vec objectAtIndex:2] floatValue]
											 y:[[vec objectAtIndex:3] floatValue]];
			
			[colmap.lines addObject:[QSTLine lineWithA:v1 b:v2]];
		}
		[physicsSystem setCollisionMap:colmap forLayer:theIndex];
	}
	
	NSMutableArray *r_entities = [layerData objectForKey:@"entities"];
	
	for(NSMutableDictionary *r_entity in r_entities) {
		QSTEntity *entity = [self createEntity:r_entity layer:theIndex];
		
		if(entity != nil) {
			[layer registerEntity:entity];
			[physicsSystem registerEntity:entity inLayer:theIndex];
			
			[graphicsSystem.camera follow:entity withSpeed:0.0f];
		}
	}
	
	[graphicsSystem addLayer:layer];
}

-(QSTEntity*)createEntity:(NSMutableDictionary*)data layer:(int)layerIndex {
	NSString *r_entity_type = [data objectForKey:@"type"];
	
	printf("Create entity of type %s...\n", [r_entity_type UTF8String]);
	
	// Get archetype
	QSTEntity *ent = [QSTEntity entityWithType:r_entity_type];
	if(ent == nil) return nil;
		
	// Override with specific
	NSMutableDictionary *r_entity_components = [data objectForKey:@"components"];
	NSDictionary *properties = [QSTPropertyDB propertiesFromDictionary:r_entity_components];
	for(NSString *key in properties)
		[ent setProperty:key to:[properties objectForKey:key]];
		
	return ent;
}

-(void)registerWithSystems:(QSTEntity*)entity layer:(int)layerIndex {
	//[graphicsSystem registerEntity:entity inLayer:layerIndex];
	[physicsSystem registerEntity:entity inLayer:layerIndex];
}

-(void)jump {
	printf("JUMP!\n");
	//playerPhys.velocity.y = -4.0f;
}

-(void)leftStart {
}

-(void)leftStop {
}

-(void)rightStart {
}

-(void)rightStop {
}

-(void)tick {
		
	float delta = 0.0166f;

	[physicsSystem tick:delta];
	[graphicsSystem tick:delta];
}

@end
