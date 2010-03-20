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
@class QSTNetworkSystem;
@class QSTPropertyDB;
@class QSTResourceDB;

@interface QSTCore : NSObject {
	QSTGraphicsSystem	*graphicsSystem;
	QSTPhysicsSystem	*physicsSystem;
	QSTInputSystem		*inputSystem;
	QSTNetworkSystem  *networkSystem;
	
	QSTPropertyDB     *propertyDB;
	QSTResourceDB     *resourceDB;
	
	NSURL *gamePath;

}

@property (nonatomic,readonly,retain) QSTGraphicsSystem *graphicsSystem;
@property (nonatomic,readonly,retain) QSTPhysicsSystem *physicsSystem;
@property (nonatomic,readonly,retain) QSTInputSystem *inputSystem;
@property (nonatomic,readonly,retain) QSTNetworkSystem *networkSystem;

@property (nonatomic,readonly,retain) QSTPropertyDB *propertyDB;
@property (nonatomic,readonly,retain) QSTResourceDB *resourceDB;

@property (nonatomic,readonly,copy) NSURL *gamePath;

-(id)initWithGame:(NSURL*)gamePath;
-(void)loadArea:(NSString*)areaName;
-(void)loadLayer:(NSMutableDictionary*)layerData withIndex:(int)theIndex;
-(QSTEntity*)createEntity:(NSMutableDictionary*)data layer:(int)layerIndex;
-(void)registerWithSystems:(QSTEntity*)entity layer:(int)layerIndex;

-(void)tick;

@end
