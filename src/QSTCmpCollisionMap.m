//
//  QSTCmpCollisionMap.m
//  Quest
//
//  Created by Per Borgman on 25/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCmpCollisionMap.h"

#import "QSTLine.h"
#import "Vector2.h"

@implementation QSTCmpCollisionMap

@synthesize lines;

-(id)initWithEID:(int)theEID {
	if(self = [super init]) {
		EID = theEID;
		
		lines = [[NSMutableArray array] retain];
		
		QSTLine *line1 = [[QSTLine alloc] initWithX1:0.0f y1:1.0f x2:2.0f y2:7.0f];
		QSTLine *line2 = [[QSTLine alloc] initWithX1:2.0f y1:7.0f x2:6.0f y2:7.0f];
		QSTLine *line3 = [[QSTLine alloc] initWithX1:6.0f y1:7.0f x2:8.0f y2:3.0f];
		
		[lines addObject:line1];
		[lines addObject:line2];
		[lines addObject:line3];
		
		[line1 release];
		[line2 release];
		[line3 release];
	}
	return self;
}

-(void)debugDraw {
	glDisable(GL_TEXTURE_2D);
	glBegin(GL_LINES);
	glColor3f(1.0f, 1.0f, 0.0f);
	for(QSTLine *l in lines) {
		glVertex2f(l.a.x, l.a.y);
		glVertex2f(l.b.x, l.b.y);
	}
	glEnd();
	glEnable(GL_TEXTURE_2D);
}

@end
