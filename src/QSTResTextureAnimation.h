//
//  QSTResTextureAnimation.h
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResTextureStrip.h"

@class QSTBoundingBox;

/*
 =================
 QSTResTextureAnimation
 
 Texture strip with additional data for animating.
 =================
 */
@interface QSTResTextureAnimation : QSTResTextureStrip {
	int				startFrame;
	int				loopStart;
	int				maxFrames;	// This value can differ from the actual number of frames
								// in the texture.
	
	float			fps;
}

@property (nonatomic,readonly) int maxFrames;

-(id)initWithData:(NSMutableDictionary*)data path:(NSURL*)path;
-(QSTBoundingBox*)useWithFrame:(int)frame;

@end