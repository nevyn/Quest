//
//  QSTBoundingBox.m
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTBoundingBox.h"

#import "Vector2.h"

@implementation QSTBoundingBox

@synthesize min;
@synthesize max;

+(id)bboxWithMinX:(float)minX minY:(float)minY maxX:(float)maxX maxY:(float)maxY {
	return [[[QSTBoundingBox alloc] initWithMinX:minX minY:minY maxX:maxX maxY:maxY] autorelease];
}

-(id)initWithMinX:(float)minX minY:(float)minY maxX:(float)maxX maxY:(float)maxY {
	if(self = [super init]) {
		min = [[Vector2 vectorWithX:minX y:minY] retain];
		max = [[Vector2 vectorWithX:maxX y:maxY] retain];
	}
	return self;
}

@end
