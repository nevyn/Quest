//
//  QSTCore.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTGraphicsSystem;
@class QSTPhysicsSystem;
@class QSTInputSystem;
@class QSTCmpPhysics;
@class QSTEntity;

@interface QSTCore : NSObject {
	QSTGraphicsSystem	*graphicsSystem;
	QSTPhysicsSystem	*physicsSystem;
	QSTInputSystem		*inputSystem;
	
	NSURL *gamePath;
	
	// Ytterst temp
	QSTCmpPhysics	*playerPhys;
}

@property (nonatomic,readonly) QSTGraphicsSystem *graphicsSystem;
@property (nonatomic,readonly) QSTPhysicsSystem *physicsSystem;
@property (nonatomic,readonly) QSTInputSystem *inputSystem;
@property (nonatomic,readonly, copy) NSURL *gamePath;
-(id)initWithGame:(NSURL*)gamePath;
-(void)loadArea:(NSString*)areaName;
-(void)loadLayer:(NSMutableDictionary*)theLayer withIndex:(int)theIndex;
-(void)createEntity:(NSMutableDictionary*)data layer:(int)layerIndex;
-(void)registerWithSystems:(QSTEntity*)entity layer:(int)layerIndex;

-(void)tick;

@end

// Evil global!
QSTCore *core;

