//
//  QSTResTextureStrip.m
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResTextureStrip.h"

#import "QSTResourceDB.h"
#import "QSTResTexture.h"
#import "QSTBoundingBox.h"

@implementation QSTResTextureStrip

@synthesize subdivs;

-(id)initWithTexturePath:(NSURL*)path frames:(int)frames {
	if(self = [super init]) {
		texture = [[QSTResourceDB getTextureWithPath:path] retain];
		
		//int frameSize = texture.width / frames;
		float subsize = 1.0f / frames;		
		
		subdivs = [[NSMutableArray array] retain];
		
		float currentX = 0.0f;
		for(int i=0; i<frames; i++) {
			QSTBoundingBox *box = [QSTBoundingBox bboxWithMinX:currentX minY:0.0f maxX:currentX+subsize maxY:1.0f];
			[subdivs addObject:box];
			currentX += subsize;
		}
	}
	return self;
}

@end
