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
#import "QSTResSprite.h"
#import "QSTResourceDB.h"


@implementation QSTCmpSprite

-(id)initWithEID:(int)theEID name:(NSString*)spriteName position:(QSTCmpPosition*)thePosition {
	if(self = [super init]) {
		EID = theEID;
		position = [thePosition retain];
		sprite = [[QSTResourceDB getSpriteWithName:spriteName] retain];
	}
	return self;
}

-(void)render {
	Vector2	*pos = position.position;
	
	[sprite use];
	
	glPushMatrix();
	
	glTranslatef(pos.x, pos.y, 0.0f);
	
	glBegin(GL_QUADS);
	glColor3f(1.0f, 1.0f, 1.0f);

	glTexCoord2f(0.0f, 0.0f);
	glVertex3f(0.0f, 0.0f, 0.0f);
	
	glTexCoord2f(1.0f, 0.0f);
	glVertex3f(1.0f, 0.0f, 0.0f);
	
	glTexCoord2f(1.0f, 1.0f);
	glVertex3f(1.0f, 1.0f, 0.0f);
	
	glTexCoord2f(0.0f, 1.0f);
	glVertex3f(0.0f, 1.0f, 0.0f);
	glEnd();
	
	glPopMatrix();
}

@end
