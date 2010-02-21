//
//  QSTCmpSprite.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCmpSprite.h"

#import <OpenGL/OpenGL.h>

#import "Vector2.h"
#import "QSTCmpPosition.h"


@implementation QSTCmpSprite

-(id)initWithEID:(int)theEID position:(QSTCmpPosition*)thePosition {
	if(self = [super init]) {
		EID = theEID;
		position = thePosition;
	}
	return self;
}

-(void)render {
	Vector2	*pos = position.position;
	glTranslatef(pos.x, pos.y, 0.0f);
	
	glBegin(GL_QUADS);
	glColor3f(1.0f, 1.0f, 1.0f);
	glVertex3f(0.0f, 0.0f, 0.0f);
	glVertex3f(1.0f, 0.0f, 0.0f);
	glVertex3f(1.0f, 1.0f, 0.0f);
	glVertex3f(0.0f, 1.0f, 0.0f);
	glEnd();
}

@end
