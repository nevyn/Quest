//
//  QSTLogicWalker.m
//  Quest
//
//  Created by Per Borgman on 2010-03-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLogicWalker.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

#import "Vector2.h"

@implementation QSTLogicWalker

-(void)tick:(float)delta {
	
	// Check what's in front.
	// If obstacle or hole, change direction
	
	// ColResult onground = getGround:bbox;
	// if(onground) vel.x *= -1.0f;
	
	QSTProperty *vel = [owner property:@"Velocity"];
	[vel vectorVal].x = 1.0f;
}

@end
