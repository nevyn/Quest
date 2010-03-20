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

/*@interface QSTBatch {
	QSTBatchSettings	settings;
	NSArray				*components;
}
@end*/


@interface QSTGraphicsSystem : NSObject {
	NSMutableArray		*layers;
		
	int	pixelToUnitRatio;	// Pixels per unit at normal zoom
}

-(id)init;
-(void)tick;
-(void)beginFrame;

-(void)addLayer:(QSTLayer*)theLayer;

/*
-(void)registerEntity:(QSTEntity*)entity inLayer:(int)layer;
-(void)setTerrain:(QSTTerrain*)tTerrain forLayer:(int)layer;
*/

@end
