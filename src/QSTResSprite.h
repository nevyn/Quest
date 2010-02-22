//
//  QSTResSprite.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
 
	Sprite
 
	A sprite is basically a collection of animations. The
	animations can differ in length. There is always one and
	only one animation active.
 
	All individual frames in all animations should have the
	same size. Each animation is laid out in one texture.
 
*/

@class Vector2;

@interface QSTResSprite : NSObject {
	NSArray	*animations;
	Vector2	*frameSize;
}

-(void)setAnimation:(int)animNum;
-(void)setFrame:(int)frameNum;

@end
