//
//  GraphicsSystem.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTGraphicsSystem.h"

#import "QSTSceneLayered2D.h"


typedef struct {
} QSTBatchSettings;


/*@implementation QSTBatch

-(void)render: {
	for(QSTComponent *aComponent in components) {
		aComponent.
	}
}

@end*/


@implementation QSTGraphicsSystem

@synthesize scene;

-(id)init {
	if(self = [super init]) {
		scene = [[QSTSceneLayered2D alloc] init];
	}
	return self;
}

-(void)tick {	
	// Render world and entities
	[scene render];
	
	// GUI
}

@end
