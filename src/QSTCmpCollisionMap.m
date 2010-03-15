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
		
		float cx = l.a.x + ((l.b.x - l.a.x) / 2.0f);
		float cy = l.a.y + ((l.b.y - l.a.y) / 2.0f);
		
		glVertex2f(cx, cy);
		glVertex2f(cx + l.normal.x, cy + l.normal.y);
	}
	glEnd();
	glEnable(GL_TEXTURE_2D);
}

@end
