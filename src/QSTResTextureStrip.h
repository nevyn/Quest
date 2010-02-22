//
//  QSTResTextureStrip.h
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTResTexture;

/*
 =============
 QSTResTextureStrip
 
 A texture with associated texture coordinates,
 subdividing the texture into equally sized sub-textures.
 =============
 */
@interface QSTResTextureStrip : NSObject {
	QSTResTexture	*texture;
	NSMutableArray	*subdivs;	// Array of bboxes with tex coords
}

@property (nonatomic,readonly) NSMutableArray *subdivs;

-(id)initWithTexturePath:(NSString*)path frames:(int)frames;

@end