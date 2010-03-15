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

#import "QSTCmpCollisionMap.h"

#import "QSTEntity.h"
#import "QSTResourceDB.h"
#import "QSTPropertyDB.h"

@implementation QSTCore

@synthesize graphicsSystem;
@synthesize physicsSystem;
@synthesize inputSystem;

-(id)init {
	if(self = [super init]) {
		graphicsSystem = [[QSTGraphicsSystem alloc] init];
		physicsSystem = [[QSTPhysicsSystem alloc] init];
		inputSystem = [[QSTInputSystem alloc] init];
		
		QSTInputMapper *mapper = [[QSTInputMapper alloc] init];
		[mapper registerActionWithName:@"jump" action:@selector(jump) target:self];
		[mapper mapKey:49 toAction:@"jump"];
		inputSystem.mapper = mapper;
		[mapper release];
		
		
		[self loadArea:@"test"];
	}
	return self;
}

-(void)loadArea:(NSString*)areaName {
	NSString *areaPath = [NSString stringWithFormat:@"testgame/areas/%@.area", areaName];
	
	NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONPath:areaPath];
	
	// Later there will be some area-global data here, like
	// music and mood etc
				
	NSMutableArray *r_layers = [r_root objectForKey:@"layers"];
	for(int i=0; i<[r_layers count];i++)
		[self loadLayer:[r_layers objectAtIndex:i] withIndex:i];
}

-(void)loadLayer:(NSMutableDictionary*)theLayer withIndex:(int)theIndex {
	
	printf("Load layer %d...\n", theIndex);
	
	NSMutableArray *r_colmap = [theLayer objectForKey:@"colmap"];
	
	QSTCmpCollisionMap *colmap = [[QSTCmpCollisionMap alloc] initWithEID:0];
	for(NSMutableArray *vec in r_colmap) {
		Vector2 *v1 = [Vector2 vectorWithX:[[vec objectAtIndex:0] floatValue]
										 y:[[vec objectAtIndex:1] floatValue]];
		Vector2 *v2 = [Vector2 vectorWithX:[[vec objectAtIndex:2] floatValue]
										 y:[[vec objectAtIndex:3] floatValue]];
		
		[colmap.lines addObject:[QSTLine lineWithA:v1 b:v2]];
	}
	[physicsSystem setCollisionMap:colmap forLayer:theIndex];
		
	NSMutableArray *r_entities = [theLayer objectForKey:@"entities"];
	
	for(NSMutableDictionary *r_entity in r_entities) {
		[self createEntity:r_entity layer:theIndex];
	}
}

-(void)createEntity:(NSMutableDictionary*)data layer:(int)layerIndex {
	NSString *r_entity_type = [data objectForKey:@"type"];
	
	printf("Create entity of type %s...\n", [r_entity_type UTF8String]);
	
	// Get archetype
	QSTEntity *ent = [QSTEntity entityWithType:r_entity_type];
		
	// Override with specific
	NSMutableDictionary *r_entity_components = [data objectForKey:@"components"];
	NSDictionary *properties = [QSTPropertyDB propertiesFromDictionary:r_entity_components];
	for(NSString *key in properties)
		[ent setProperty:key to:[properties objectForKey:key]];
		
	[self registerWithSystems:ent layer:layerIndex];
}

-(void)registerWithSystems:(QSTEntity*)entity layer:(int)layerIndex {
	[graphicsSystem registerEntity:entity inLayer:layerIndex];
	[physicsSystem registerEntity:entity inLayer:layerIndex];
}

-(void)jump {
	printf("JUMP!\n");
	//playerPhys.velocity.y = -4.0f;
}

-(void)tick {
		
	float delta = 0.0166f;

	[physicsSystem tick:delta];
	[graphicsSystem tick];
}

@end
