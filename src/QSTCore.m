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
#import "QSTNetworkSystem.h"
#import "QSTLogicsSystem.h"

#import "QSTEntityDB.h"
#import "QSTResourceDB.h"
#import "QSTPropertyDB.h"

#import "QSTLog.h"

@interface QSTCore ()
@property (nonatomic,readwrite,retain) QSTGraphicsSystem *graphicsSystem;
@property (nonatomic,readwrite,retain) QSTPhysicsSystem *physicsSystem;
@property (nonatomic,readwrite,retain) QSTInputSystem *inputSystem;
@property (nonatomic,readwrite,retain) QSTNetworkSystem *networkSystem;
@property (nonatomic,readwrite,retain) QSTLogicsSystem *logicsSystem;

@property (nonatomic,readwrite,retain) QSTEntityDB *entityDB;
@property (nonatomic,readwrite,retain) QSTPropertyDB *propertyDB;
@property (nonatomic,readwrite,retain) QSTResourceDB *resourceDB;

@property (nonatomic,readwrite,retain) QSTGame *game;

@property (nonatomic,readwrite, copy) NSURL *gamePath;
@end

static QSTLogger *syslog = nil;

@implementation QSTCore
@synthesize graphicsSystem, physicsSystem, inputSystem, networkSystem, logicsSystem;
@synthesize entityDB, propertyDB, resourceDB;
@synthesize gamePath, mode;
@synthesize game;

-(id)initWithGame:(NSURL*)gamePath_ inMode:(QSTMode)mode_;
{
	if(![super init]) return nil;
	
	Info(@"Engine", @"-------- Initializing Core --------");
		
	self.gamePath = gamePath_;
	mode = mode_;
	
	Info(@"Engine", @"Running game: %@", [self.gamePath relativePath]);

	self.entityDB = [[[QSTEntityDB alloc] initOnCore:self] autorelease];
	self.propertyDB = [[[QSTPropertyDB alloc] initOnCore:self] autorelease];
	self.resourceDB = [[[QSTResourceDB alloc] initOnCore:self] autorelease];
	
	graphicsSystem = [[QSTGraphicsSystem alloc] initOnCore:self];
	inputSystem = [[QSTInputSystem alloc] init];
	if(!(mode & QSTSlave)) {
		physicsSystem = [[QSTPhysicsSystem alloc] initOnCore:self];
		logicsSystem = [[QSTLogicsSystem alloc] initOnCore:self];
	}
	if(mode != QSTStandalone)
		networkSystem = [[QSTNetworkSystem alloc] initOnCore:self];
	
	self.game = [[QSTGame alloc] initOnCore:self];
	
	QSTInputMapper *mapper = [[[QSTInputMapper alloc] init] autorelease];
	if(!(mode & QSTSlave)) {
	 	[mapper registerStateActionWithName:@"left" beginAction:@selector(leftStart) endAction:@selector(leftStop) target:game];
		[mapper registerStateActionWithName:@"right" beginAction:@selector(rightStart) endAction:@selector(rightStop) target:game];
		[mapper registerActionWithName:@"jump" action:@selector(jump) target:game];
	}
	[mapper mapKey:123 toAction:@"left"];
	[mapper mapKey:124 toAction:@"right"];
	[mapper mapKey:49 toAction:@"jump"];
	
	inputSystem.mapper = mapper;
	
	[game loadArea:@"jump"];
	
	return self;
}
-(void)dealloc;
{
	self.graphicsSystem = nil;
	self.physicsSystem = nil;
	self.inputSystem = nil;
	self.networkSystem = nil;
	self.logicsSystem = nil;
	self.gamePath = nil;
	self.entityDB = nil;
	self.propertyDB = nil;
	self.resourceDB = nil;
	self.game = nil;
	[super dealloc];
}

-(void)tick {
		
	float delta = 1.0f / 60.0f;

	[logicsSystem tick:delta];
	[physicsSystem tick:delta];
	[graphicsSystem tick:delta];
}

@end
