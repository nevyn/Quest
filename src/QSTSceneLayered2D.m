//
//  QSTSceneLayered2D.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTSceneLayered2D.h"

#import "QSTGraphicsSystem.h"

@implementation QSTLayer2D

-(id)init {
	if(self = [super init]) {
		components = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)addComponent:(id<QSTCmpGraphics>)aComponent {
	[components addObject:aComponent];
}

-(void)render {
	for(id<QSTCmpGraphics> gfx in components)
		[gfx render];
}

@end


@implementation QSTSceneLayered2D

-(id)init {
	if(self = [super init]) {
		layers = [[NSMutableArray alloc] init];
		
		QSTLayer2D *layer = [[QSTLayer2D alloc] init];
		
		[layers addObject:layer];
		[layer release];
	}
	return self;
}

-(void)addComponent:(id<QSTCmpGraphics>)aComponent toLayer:(int)layerIndex {
	QSTLayer2D *layer = [layers objectAtIndex:layerIndex];
	[layer addComponent:aComponent];
}

-(void)render {
	for(QSTLayer2D *layer in layers)
		[layer render];
	
	
	//[self initFrame];
	//QSTBatch *batch;
	//while(batch = [self getNextBatch]) {
	//	[batch render];
	//}
}

@end
