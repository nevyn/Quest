//
//  GraphicsSystem.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTEntity;
@class QSTTerrain;
@class QSTLayer;
@class Vector2;
@class MutableVector2;
@class QSTCamera;

/*@interface QSTBatch {
	QSTBatchSettings	settings;
	NSArray				*components;
}
@end*/

@interface QSTGraphicsSystem : NSObject {
	QSTCamera			*camera;
	NSMutableArray		*layers;
		
	int	pixelToUnitRatio;	// Pixels per unit at normal zoom
}

@property (nonatomic,readonly) QSTCamera *camera;

-(id)init;
-(void)tick:(float)delta;
-(void)beginFrame;

-(void)newSceneWithWidth:(int)w height:(int)h;

-(void)addLayer:(QSTLayer*)theLayer;
-(QSTLayer*)layer:(int)layerIndex;

/*
-(void)registerEntity:(QSTEntity*)entity inLayer:(int)layer;
-(void)setTerrain:(QSTTerrain*)tTerrain forLayer:(int)layer;
*/

@end
