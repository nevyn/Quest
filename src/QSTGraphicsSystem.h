//
//  GraphicsSystem.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class QSTSceneLayered2D;


@protocol QSTCmpGraphics

-(void)render;

@end


@protocol QSTScene
@end

/*@interface QSTBatch {
	QSTBatchSettings	settings;
	NSArray				*components;
}
@end*/


@interface QSTGraphicsSystem : NSObject {
	// Egentligen id eller id<QSTScene>
	QSTSceneLayered2D	*scene;
	
	int	pixelToUnitRatio;	// Pixels per unit at normal zoom
}

-(id)init;
-(void)tick;
-(void)beginFrame;

@property (nonatomic,readonly) QSTSceneLayered2D *scene;

@end
