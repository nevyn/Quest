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
@end


@implementation QSTLayer
@synthesize resourceDB;

-(id)initUsingResourceDB:(QSTResourceDB*)resourceDB_;
{
 if(![super init]) return nil;
	
	self.resourceDB = resourceDB_;
	entities = [[NSMutableArray alloc] init];
	
	return self;
}
-(void)dealloc;
{
	[entities release]; entities = nil;
	self.terrain = nil;
	self.resourceDB = nil;
	[super dealloc];
}

-(void)registerEntity:(QSTEntity*)entity {
	if([entity property:@"SpriteName"] == nil) return;
	[entities addObject:entity];
}

-(void)addEntity:(QSTEntity*)entity {
	[entities addObject:entity];
}
@synthesize terrain;

-(void)render {
	[self renderEntities];
	[self renderTerrain];
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

@end
