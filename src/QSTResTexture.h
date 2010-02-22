//
//  QSTResTexture.h
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
 
	A texture
 
	Textures are used for everything graphical - sprites, tiles, effects, etc.
	A texture is only loaded once and shared between all graphical components.
 
*/

@interface QSTResTexture : NSObject {
	int		oglID;
}

@end
