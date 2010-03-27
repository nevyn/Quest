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
@class QSTNetworkSystem;
@class QSTLogicsSystem;
@class QSTEntityDB;
@class QSTPropertyDB;
@class QSTResourceDB;

typedef enum {
	QSTStandalone = 0,
	QSTMaster = 1<<1,
	QSTSlave  = 1<<2,
} QSTMode;

@interface QSTCore : NSObject {
	QSTGraphicsSystem	*graphicsSystem;
	QSTPhysicsSystem	*physicsSystem;
	QSTInputSystem		*inputSystem;
	QSTNetworkSystem	*networkSystem;
	QSTLogicsSystem		*logicsSystem;
	
	QSTEntityDB		  *entityDB;
	QSTPropertyDB     *propertyDB;
	QSTResourceDB     *resourceDB;
	
	NSURL *gamePath;

	QSTGame	*game;
	QSTMode mode;
}

@property (nonatomic,readonly,retain) QSTGraphicsSystem *graphicsSystem;
@property (nonatomic,readonly,retain) QSTPhysicsSystem *physicsSystem;
@property (nonatomic,readonly,retain) QSTInputSystem *inputSystem;
@property (nonatomic,readonly,retain) QSTNetworkSystem *networkSystem;
@property (nonatomic,readonly,retain) QSTLogicsSystem *logicsSystem;

@property (nonatomic,readonly,retain) QSTEntityDB *entityDB;
@property (nonatomic,readonly,retain) QSTPropertyDB *propertyDB;
@property (nonatomic,readonly,retain) QSTResourceDB *resourceDB;

@property (nonatomic,readonly) QSTGame *game;

@property (nonatomic,readonly,copy) NSURL *gamePath;
@property (nonatomic,readonly) QSTMode mode;

-(id)initWithGame:(NSURL*)gamePath inMode:(QSTMode)mode_;

-(void)tick;

@end
