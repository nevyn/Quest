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

#import "QSTGame.h"
#import "QSTGraphicsSystem.h"
#import "QSTPhysicsSystem.h"
#import "QSTInputSystem.h"

#import "QSTEntityDB.h"
#import "QSTResourceDB.h"
#import "QSTPropertyDB.h"

@interface QSTCore ()
@property (nonatomic,readwrite,retain) QSTGraphicsSystem *graphicsSystem;
@property (nonatomic,readwrite,retain) QSTPhysicsSystem *physicsSystem;
@property (nonatomic,readwrite,retain) QSTInputSystem *inputSystem;
@property (nonatomic,readwrite,retain) QSTNetworkSystem *networkSystem;

@property (nonatomic,readwrite,retain) QSTEntityDB *entityDB;
@property (nonatomic,readwrite,retain) QSTPropertyDB *propertyDB;
@property (nonatomic,readwrite,retain) QSTResourceDB *resourceDB;

@property (nonatomic,readwrite, copy) NSURL *gamePath;
@end


@implementation QSTCore
@synthesize graphicsSystem, physicsSystem, inputSystem, networkSystem;
@synthesize entityDB, propertyDB, resourceDB;
@synthesize gamePath;

-(id)initWithGame:(NSURL*)gamePath_;
{
	if(![super init]) return nil;
	
	self.gamePath = gamePath_;

	self.entityDB = [[[QSTEntityDB alloc] initOnCore:self] autorelease];
	self.propertyDB = [[[QSTPropertyDB alloc] initOnCore:self] autorelease];
	self.resourceDB = [[[QSTResourceDB alloc] initOnCore:self] autorelease];
	
	graphicsSystem = [[QSTGraphicsSystem alloc] initOnCore:self];
	physicsSystem = [[QSTPhysicsSystem alloc] initOnCore:self];
	inputSystem = [[QSTInputSystem alloc] init];
	
	game = [[QSTGame alloc] initOnCore:self];
	
	QSTInputMapper *mapper = [[QSTInputMapper alloc] init];
	[mapper registerStateActionWithName:@"left" beginAction:@selector(leftStart) endAction:@selector(leftStop) target:game];
	[mapper registerStateActionWithName:@"right" beginAction:@selector(rightStart) endAction:@selector(rightStop) target:game];
	[mapper registerActionWithName:@"jump" action:@selector(jump) target:game];
	[mapper mapKey:123 toAction:@"left"];
	[mapper mapKey:124 toAction:@"right"];
	[mapper mapKey:49 toAction:@"jump"];
	inputSystem.mapper = mapper;
	[mapper release];
	
	[game loadArea:@"jump"];
	
	return self;
}
-(void)dealloc;
{
	self.graphicsSystem = nil;
	self.physicsSystem = nil;
	self.inputSystem = nil;
	self.networkSystem = nil;
	self.gamePath = nil;
	self.entityDB = nil;
	self.propertyDB = nil;
	self.resourceDB = nil;
	[super dealloc];
}


-(void)tick {
		
	float delta = 0.0166f;

	[physicsSystem tick:delta];
	[graphicsSystem tick:delta];
}

@end
