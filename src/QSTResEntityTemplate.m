//
//  QSTEntityTemplate.m
//  Quest
//
//  Created by Per Borgman on 28/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResEntityTemplate.h"

#import "JSON.h"

#import "QSTCmpPosition.h"
#import "QSTCmpSprite.h"
#import "QSTCmpPhysics.h"
#import "Vector2.h"
#import "QSTCore.h"
#import "QSTGraphicsSystem.h"
#import "QSTPhysicsSystem.h"
#import "QSTSceneLayered2D.h"

@implementation QSTTemplateNode

+(QSTTemplateNode*)initWithDictionary:(NSMutableDictionary*)dict {
	QSTTemplateNode *node;
	
	for(NSString *key in dict) {
		QSTTemplateNode *n;
		id obj = [dict objectForKey:key];
		if([obj isKindOfClass:[NSMutableDictionary class]]) {
		}
	}
	
	return node;
}

@end


@implementation QSTResEntityTemplate

@synthesize components;

-(id)initWithName:(NSString*)name {
	if(self = [super init]) {
		// Load template
		NSURL *templatePath = $joinUrls(core.gamePath, @"entities", [name stringByAppendingPathExtension:@"ent"]);
		NSString *rawTemplate = [NSString stringWithContentsOfURL:templatePath encoding:NSUTF8StringEncoding error:NULL];
				
		SBJsonParser *parser = [[SBJsonParser alloc] init];
		root = [QSTTemplateNode nodeWithDictionary:[parser objectWithString:rawTemplate]];
		
		//components = [[parser objectWithString:rawTemplate] retain];
		[parser release];
	}
	return self;
}

-(NSMutableDictionary*)deepCopy:(NSMutableDictionary*)dict {
	NSMutableDictionary *newDict;
	
	for(NSString *key in dict) {
		
	}
	
	return newDict;
}

-(id)initWithComponents:(NSMutableDictionary*)theComps {
	if(self = [super init]) {
		components = [theComps retain];
	}
	return self;
}

-(QSTResEntityTemplate*)templateOverriddenWith:(QSTResEntityTemplate*)other {
	printf("Forsoka...");
	QSTResEntityTemplate *newTem = [[QSTResEntityTemplate alloc] initWithComponents:[[self components] copy]];
	
	// OM DET VERKAR BLI NÅT FEL NÅNSTANS; KOLLA HÄR FÖRST! copyn kanske inte funkar som den ska.
	
	for(NSString *key in other.components) {
		
		[newTem.components setObject:[other.components objectForKey:key] forKey:key];
		
		//o = [components objectForKey:key];
		//if(o != nil) {
		//	
		//}
	}
	
	return newTem;
}

-(void)instantiate {
	// Remember! Order is important.	
	QSTCmpPosition *pos;
	for(NSString *key in components) {
		if([key isEqualToString:@"Position"]) {
			NSMutableArray *r_pos = [components objectForKey:key];
			float x = [[r_pos objectAtIndex:0] floatValue];
			float y = [[r_pos objectAtIndex:1] floatValue];
			
			pos = [[QSTCmpPosition alloc] initWithEID:1];
			pos.position.x = x;
			pos.position.y = y;
		}
	}
	
	QSTCmpSprite *sprite;
	for(NSString *key in components) {
		if([key isEqualToString:@"Sprite"]) {
			NSString *r_sprite = [components objectForKey:key];
			
			sprite = [[QSTCmpSprite alloc] initWithEID:1 name:r_sprite position:pos];
			
			[core.graphicsSystem.scene addComponent:sprite toLayer:0];
		}
	}
	
	for(NSString *key in components) {
		if([key isEqualToString:@"Physics"]) {
			QSTCmpPhysics *ph = [[QSTCmpPhysics alloc] initWithEID:1 position:pos sprite:sprite];
			[core.physicsSystem addComponent:ph toLayer:0];
		}
	}	
}

@end
