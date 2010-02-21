//
//  QSTSceneLayered2D.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTSceneLayered2D.h"

@implementation QSTLayer2D

-(id)init {
	if(self = [super init]) {
		components = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)addComponent:(QSTCmpGraphics*)aComponent {
	[components addObject:aComponent];
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

-(void)addComponent:(QSTCmpGraphics*)aComponent toLayer:(int)layerIndex {
	QSTLayer2D *layer = [layers objectAtIndex:layerIndex];
	[layer addComponent:aComponent];
}

-(void)render {
	//[self initFrame];
	//QSTBatch *batch;
	//while(batch = [self getNextBatch]) {
	//	[batch render];
	//}
}

@end
