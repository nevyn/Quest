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

-(id)initWithData:(unsigned char*)data width:(int)width height:(int)height {
	if(self = [super init]) {
		GLuint texId;
		glGenTextures(1, &texId);
		glBindTexture(GL_TEXTURE_2D, texId);
		
		oglID = texId;
		
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA,
					 width, height, 0, 
					 GL_RGBA, GL_UNSIGNED_BYTE,
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
