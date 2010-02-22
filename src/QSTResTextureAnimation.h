//
//  QSTResTextureAnimation.h
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResTextureStrip.h"

/*
 =================
 QSTResTextureAnimation
 
 Texture strip with additional data for animating.
 =================
 */
@interface QSTResTextureAnimation : QSTResTextureStrip {
	int				startFrame;
	int				loopStart;
	int				maxFrames;
	
	float			fps;
}
@end