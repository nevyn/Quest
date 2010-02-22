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
#import "QSTBoundingBox.h"


@implementation QSTCmpSprite

-(id)initWithEID:(int)theEID name:(NSString*)spriteName position:(QSTCmpPosition*)thePosition {
	if(self = [super init]) {
		EID = theEID;
		position = [thePosition retain];
		sprite = [[QSTResourceDB getSpriteWithName:spriteName] retain];
		currentFrame = 0;
		currentAnimation = @"idle";
	}
	return self;
}

-(void)render {
	Vector2	*pos = position.position;
	Vector2 *min = sprite.canvas.min;
	Vector2 *max = sprite.canvas.max;
	
	[sprite useWithAnimation:currentAnimation frame:currentFrame];
		
	QSTBoundingBox *tex = [sprite texCoordsForAnimation:currentAnimation frame:currentFrame];
		
	glPushMatrix();
		
	glTranslatef(pos.x, pos.y, 0.0f);
	//glRotatef(currentFrame, 0.0f, 0.0f, 1.0f);
		
	glBegin(GL_QUADS);
	glColor3f(1.0f, 1.0f, 1.0f);
	
	glTexCoord2f(tex.min.x, tex.min.y);
	glVertex2f(min.x, min.y);
	
	glTexCoord2f(tex.max.x, tex.min.y);
	glVertex2f(max.x, min.y);
	
	glTexCoord2f(tex.max.x, tex.max.y);
	glVertex2f(max.x, max.y);
	
	glTexCoord2f(tex.min.x, tex.max.y);
	glVertex2f(min.x, max.y);
	
	glEnd();
	
	glDisable(GL_TEXTURE_2D);
	glBegin(GL_POINTS);
	glColor3f(1.0f, 0.0f, 0.0f);
	glVertex2f(0.0f, 0.0f);
	glEnd();
	glEnable(GL_TEXTURE_2D);
	
	glPopMatrix();
	
	currentFrame += 1;
	if(currentFrame >= [sprite maxFramesForAnimation:currentAnimation])
		currentFrame = 0;
}

@end
