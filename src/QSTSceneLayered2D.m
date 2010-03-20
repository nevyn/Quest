//
//  QSTSceneLayered2D.m
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTSceneLayered2D.h"

#import "QSTGraphicsSystem.h"
#import "QSTResourceDB.h"

#import "QSTResSprite.h"
#import "QSTTerrain.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

#import "Vector2.h"
#import "QSTBoundingBox.h"

@implementation QSTLayer2D

-(id)init {
	if(self = [super init]) {
		entities = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)addEntity:(QSTEntity*)entity {
	[entities addObject:entity];
}

-(void)setTerrain:(QSTTerrain *)tTerrain {
	terrain = [tTerrain retain];
}

-(void)render {
	printf("render layer");
	[self renderEntities];
	[self renderTerrain];
}

-(void)renderEntities {
	for(QSTEntity *ent in entities) {
		QSTProperty *sprname = [ent property:@"SpriteName"];
		QSTProperty *spranim = [ent property:@"SpriteCurrentAnimation"];
		QSTProperty *sprfrm = [ent property:@"SpriteCurrentFrame"];
		QSTProperty *position = [ent property:@"Position"];
		QSTResSprite *sprite = [QSTResourceDB getSpriteWithName:sprname.stringVal];
		
		Vector2	*pos = position.vectorVal;
		Vector2 *min = sprite.canvas.min;
		Vector2 *max = sprite.canvas.max;
		
		QSTBoundingBox *box = sprite.bbox;
		
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
	printf("render terrain");
	[terrain render];
}

@end

/*
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

-(void)addEntity:(QSTEntity*)entity toLayer:(int)layer {
	[[layers objectAtIndex:layer] addEntity:entity];
}

-(void)render {
	for(QSTLayer2D *layer in layers)
		[layer render];
	
	
	//[self initFrame];
	//QSTBatch *batch;
	//while(batch = [self getNextBatch]) {
	//	[batch render];
	//}
}

@end
*/