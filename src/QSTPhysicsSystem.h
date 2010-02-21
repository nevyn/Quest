//
//  QSTPhysicsSystem.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
	
	Physics system
 
	Also works in batches, since only entities
	within the same layer collides with each other.
 
*/

@class QSTCmpPhysics;

@interface QSTPhysicsSystem : NSObject {

	NSMutableArray	*components;
	
}

-(id)init;
-(void)addComponent:(QSTCmpPhysics*)aComponent toLayer:(int)theLayer;
-(void)tick:(float)dt;

@end
