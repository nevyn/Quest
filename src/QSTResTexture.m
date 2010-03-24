//
//  QSTResTexture.m
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResTexture.h"

#import <OpenGL/OpenGL.h>

@implementation QSTResTexture

@synthesize width;
@synthesize height;

-(id)initWithData:(unsigned char*)data width:(int)tWidth height:(int)tHeight hasAlpha:(BOOL)hasAlpha {
	if(self = [super init]) {
		GLuint texId;
		glGenTextures(1, &texId);
		glBindTexture(GL_TEXTURE_2D, texId);
		
		oglID = texId;
		width = tWidth;
		height = tHeight;
		
		glTexImage2D(GL_TEXTURE_2D, 0, hasAlpha?GL_RGBA:GL_RGB,
					 width, height, 0, 
					 hasAlpha?GL_RGBA:GL_RGB, GL_UNSIGNED_BYTE,
					 data);
		
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	}
	return self;
}

-(void)use {
	glBindTexture(GL_TEXTURE_2D, oglID);
}

@end
