//
//  QSTLayer.m
//  Quest
//
//  Created by Per Borgman on 2010-03-18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLayer.h"

#import "QSTResourceDB.h"
#import "QSTResSprite.h"

#import "QSTTerrain.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

#import "Vector2.h"
#import "QSTBoundingBox.h"

@interface QSTLayer ()
@property (nonatomic, retain) QSTResourceDB *resourceDB;
@property (nonatomic, retain) MutableVector2	*currentPosition;
@end


@implementation QSTLayer
@synthesize resourceDB, depth, width, height, terrain, currentPosition;
@synthesize startPosition;

-(id)initUsingResourceDB:(QSTResourceDB*)resourceDB_;
{
 if(![super init]) return nil;
	
	self.resourceDB = resourceDB_;
	entities = [[NSMutableArray alloc] init];
	self.currentPosition = [MutableVector2 vector];
	startPosition = [[Vector2 vector] retain];

	return self;
}
-(void)dealloc;
{
	[entities release]; entities = nil;
	self.terrain = nil;
	self.resourceDB = nil;
	self.currentPosition = nil;
	[super dealloc];
}

-(void)registerEntity:(QSTEntity*)entity {
	if([entity property:@"SpriteName"] == nil) return;
	[entities addObject:entity];
}

-(void)addEntity:(QSTEntity*)entity {
	[entities addObject:entity];
}

-(void)renderWithCameraPosition:(Vector2*)position {
	glPushMatrix();
		
	float x = -position.x*depth + 5.0f + startPosition.x*depth;
	float y = -position.y*depth + 3.75f + startPosition.y*depth;
	
	glTranslatef(x, y, 0.0f);
	glScalef(depth, depth, 1.0f);
	
	[self renderEntities];
	[self renderTerrain];
	
	[self renderBorders];
	//[self renderGrid];
	
	glPopMatrix();
}

-(void)renderEntities {
	for(QSTEntity *ent in entities) {
		QSTProperty *sprname = [ent property:@"SpriteName"];
		QSTProperty *spranim = [ent property:@"SpriteCurrentAnimation"];
		QSTProperty *sprfrm = [ent property:@"SpriteCurrentFrame"];
		QSTProperty *position = [ent property:@"Position"];
		QSTResSprite *sprite = [resourceDB getSpriteWithName:sprname.stringVal];
		
		Vector2	*pos = position.vectorVal;
		Vector2 *min = sprite.canvas.min;
		Vector2 *max = sprite.canvas.max;
		
		//QSTBoundingBox *box = sprite.bbox;
		
		QSTBoundingBox *tex = [sprite useWithAnimation:spranim.stringVal	
												 frame:(int)sprfrm.floatVal];
		
		glPushMatrix();

		//glTranslatef(pos.x * depth, pos.y * depth, 0.0f);
		glTranslatef(pos.x, pos.y, 0.0f);
		//glRotatef(currentFrame, 0.0f, 0.0f, 1.0f);
		
		/*glDisable(GL_TEXTURE_2D);
		 
		 glBegin(GL_QUADS);
		 glColor3f(1.0f, 1.0f, 0.0f);
		 glVertex2f(box.min.x, box.min.y);
		 glVertex2f(box.max.x, box.min.y);
		 glVertex2f(box.max.x, box.max.y);
		 glVertex2f(box.min.x, box.max.y);
		 glEnd();
		 
		 glEnable(GL_TEXTURE_2D);*/
		
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
		
		sprfrm.floatVal += 0.1f;
		if(sprfrm.floatVal >= [sprite maxFramesForAnimation:spranim.stringVal])
			sprfrm.floatVal = 0.0f;
	}
}

-(void)renderTerrain {
	[terrain render];
}

-(void)renderGrid {
	glDisable(GL_TEXTURE_2D);
	float color = depth / 3.0f;
	glColor3f(color,color,color);
	glLineWidth(depth * 5);
	glBegin(GL_LINES);
	for(int i=0; i<20; i++) {
		for(int j=0; j<20; j++) {
			glVertex2f(i, 0.0f);
			glVertex2f(i, 20.0f);
			glVertex2f(0.0f, j);
			glVertex2f(20.0f, j);
		}
	}
	glEnd();
	glEnable(GL_TEXTURE_2D);
}

-(void)renderBorders {
	glDisable(GL_TEXTURE_2D);
	glColor3f(1.0f,0.0f,0.0f);
	glLineWidth(depth * 2);
	glBegin(GL_LINE_LOOP);
	glVertex2f(0, 0);
	glVertex2f(width*10.0f, 0);
	glVertex2f(width*10.0f, height*7.5f);
	glVertex2f(0, height*7.5f);
	glEnd();
	glEnable(GL_TEXTURE_2D);
}

@end
