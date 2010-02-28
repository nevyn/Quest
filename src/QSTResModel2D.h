//
//  QSTResModel2D.h
//  Quest
//
//  Created by Per Borgman on 26/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
 
	2D Skeletal Model
 
	A skeleta animation driven model composed
	of several QSTResSprites.
 
*/

@class QSTResSprite;
@class Vector2;
@class MutableVector2;

// ATTN: Tänk tvärtom
@interface QSTModel2DJoint : NSObject {
	NSString			*name;
	QSTResSprite		*sprite;
	MutableVector2		*anchor;
	
	MutableVector2		*position;
	
	float				rotation;
	float				targetRotation;
	float				rotationTime;
	
	QSTModel2DJoint		*parent;
	NSMutableArray		*children;
}
@end

// When a keyframe is complete, the joint
// informs the model to fetch the next keyframe
// and start over.
@interface QSTModel2DKeyFrame : NSObject {
	float			duration;
	NSMutableArray	*joints;
}
@end

@interface QSTModel2DAnimation : NSObject {
	NSArray				*keyframes;
}
@end

@interface QSTResModel2D : NSObject {
	QSTModel2DJoint		*root;
	NSArray				*animations;
	
	Vector2				*center;
}

@end
