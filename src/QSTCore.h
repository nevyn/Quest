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

@interface QSTCore : NSObject {
	QSTGraphicsSystem	*graphicsSystem;
	QSTPhysicsSystem	*physicsSystem;
	QSTInputSystem		*inputSystem;
	
	
	// Ytterst temp
	QSTCmpPhysics	*playerPhys;
}

@property (nonatomic,readonly) QSTInputSystem *inputSystem;

-(void)tick;

@end
