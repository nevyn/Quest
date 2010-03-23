//
//  QSTGame.m
//  Quest
//
//  Created by Per Borgman on 2010-03-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTGame.h"

#import "QSTCore.h"
#import "JSONHelper.h"

#import "QSTGraphicsSystem.h"
#import "QSTCamera.h"
#import "QSTPhysicsSystem.h"

#import "QSTLayer.h"
#import "QSTTerrain.h"

#import "QSTCmpCollisionMap.h"

#import "QSTEntityDB.h"
#import "QSTPropertyDB.h"
#import "QSTEntity.h"
#import "QSTProperty.h"

#import "QSTLine.h"
#import "Vector2.h"


@interface QSTGame ()
@property (nonatomic,assign) QSTCore *core;
@end




@implementation QSTGame

@synthesize core;

-(id)initOnCore:(QSTCore*)core_ {
	if(![super init]) return nil;
	
	self.core = core_;
	
	powerUps = [[NSMutableArray alloc] init];
	playerEntity = [[core.entityDB createEntityWithType:@"lasse"] retain];
	
	printf("Game created.\n");
		
	return self;
}

-(void)dealloc {
	self.core = nil;
	[powerUps release];
	[playerEntity release];
	[super dealloc];
}

-(void)loadArea:(NSString*)areaName {
	NSURL *areaPath = [core.gamePath URLByAppendingPathComponents:$array(
																		 @"areas", $sprintf(@"%@.area", areaName)
																		 )];
	
	printf("Load Area: %s\n", [[areaPath path] UTF8String]);
			
	NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONURL:areaPath];

	NSArray *r_size = [r_root objectForKey:@"size"];
	int width = [[r_size objectAtIndex:0] intValue];
	int height = [[r_size objectAtIndex:1] intValue];
	
	[core.graphicsSystem newSceneWithWidth:width height:height];

	NSMutableArray *r_layers = [r_root objectForKey:@"layers"];
	for(int i=0; i<[r_layers count];i++) {
		[self loadLayer:[r_layers objectAtIndex:i] withIndex:i];
	}
	
	// Get placeholder entity
	QSTEntity *playerStart = [core.entityDB findEntityOfType:@"player"];
	
	[[playerEntity property:@"Position"] setVectorVal:[playerStart property:@"Position"].vectorVal];
	int layer = [playerStart property:@"Layer"].intVal;
	[playerEntity setProperty:@"Layer" to:[QSTProperty propertyWithInt:layer]];
	
	[core.graphicsSystem registerEntity:playerEntity inLayer:layer];
	[core.physicsSystem registerEntity:playerEntity inLayer:layer];
	
	[core.graphicsSystem.camera follow:playerEntity withSpeed:0.0f];
	
	// Not needed anymore
	[core.entityDB removeEntity:playerStart];
	
}

-(void)loadLayer:(NSMutableDictionary*)layerData withIndex:(int)theIndex {
	
	printf("Load layer %d...\n", theIndex);
	
	[core.graphicsSystem loadLayerWithData:layerData index:theIndex];
	[core.physicsSystem loadLayerWithData:layerData index:theIndex];
	
	NSMutableArray *r_entities = [layerData objectForKey:@"entities"];
	
	for(NSMutableDictionary *r_entity in r_entities) {
		QSTEntity *entity = [self createEntity:r_entity layer:theIndex];
		
		[core.physicsSystem registerEntity:entity inLayer:theIndex];
		[core.graphicsSystem registerEntity:entity inLayer:theIndex];
	}
}

-(QSTEntity*)createEntity:(NSMutableDictionary*)data layer:(int)layerIndex {
	NSString *r_entity_type = [data objectForKey:@"type"];
		
	// Get archetype
	QSTEntity *ent = [core.entityDB createEntityWithType:r_entity_type];
	if(ent == nil) return nil;
	
	// Override with specific
	NSMutableDictionary *r_entity_components = [data objectForKey:@"components"];
	NSDictionary *properties = [core.propertyDB propertiesFromDictionary:r_entity_components];
	for(NSString *key in properties)
		[ent setProperty:key to:[properties objectForKey:key]];
	
	QSTProperty *layerProp = [QSTProperty propertyWithInt:layerIndex];
	[ent setProperty:@"Layer" to:layerProp];
	
	return ent;
}

-(void)leftStart {
	QSTProperty *vel = [playerEntity property:@"Velocity"];
	//QSTProperty *pos = [playerEntity property:@"Position"];
	vel.vectorVal.x = -3.0f;
	
	//pos.vectorVal.x -= 1.0f;
	
	[core.graphicsSystem.camera panToX:25.0f y:3.75f withSpeed:1.0f];
	[core.graphicsSystem.camera zoomTo:2.3f withSpeed:0.4f];

}

-(void)leftStop {
	QSTProperty *vel = [playerEntity property:@"Velocity"];
	vel.vectorVal.x = 0.0f;
}

-(void)rightStart {
	QSTProperty *vel = [playerEntity property:@"Velocity"];
	//QSTProperty *pos = [playerEntity property:@"Position"];
	vel.vectorVal.x = 3.0f;
	
	//pos.vectorVal.x += 1.0f;
	
	[core.graphicsSystem.camera zoomTo:1.0f withSpeed:0.4f];
	[core.graphicsSystem.camera follow:playerEntity withSpeed:1.0f];

}

-(void)rightStop {
	QSTProperty *vel = [playerEntity property:@"Velocity"];
	vel.vectorVal.x = 0.0f;
}

-(void)jump {	
	QSTProperty *vel = [playerEntity property:@"Velocity"];
	
	//if([self hasPowerUp:@"HighJump"])
	//	vel.vectorVal.y -= 6.0f;
	//else
		vel.vectorVal.y -= 6.0f;
}

-(void)shoot {
	printf("Shoot!\n");
}

@end
