//
//  QSTCore.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTGame;
@class QSTGraphicsSystem;
@class QSTPhysicsSystem;
@class QSTInputSystem;
@class QSTCmpPhysics;
@class QSTNetworkSystem;
@class QSTEntityDB;
@class QSTPropertyDB;
@class QSTResourceDB;

@interface QSTCore : NSObject {
	QSTGraphicsSystem	*graphicsSystem;
	QSTPhysicsSystem	*physicsSystem;
	QSTInputSystem		*inputSystem;
	QSTNetworkSystem  *networkSystem;
	
	QSTEntityDB		  *entityDB;
	QSTPropertyDB     *propertyDB;
	QSTResourceDB     *resourceDB;
	
	NSURL *gamePath;

	QSTGame	*game;
}

@property (nonatomic,readonly,retain) QSTGraphicsSystem *graphicsSystem;
@property (nonatomic,readonly,retain) QSTPhysicsSystem *physicsSystem;
@property (nonatomic,readonly,retain) QSTInputSystem *inputSystem;
@property (nonatomic,readonly,retain) QSTNetworkSystem *networkSystem;

@property (nonatomic,readonly,retain) QSTEntityDB *entityDB;
@property (nonatomic,readonly,retain) QSTPropertyDB *propertyDB;
@property (nonatomic,readonly,retain) QSTResourceDB *resourceDB;

@property (nonatomic,readonly,copy) NSURL *gamePath;

-(id)initWithGame:(NSURL*)gamePath;

-(void)tick;

@end
