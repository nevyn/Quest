//
//  QSTCmpPhysics.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "QSTCmpPhysicsBase.h"

@class QSTCmpPosition;
@class QSTCmpSprite;
@class MutableVector2;
@class QSTBoundingBox;

@interface QSTCmpPhysics : NSObject {	
	int				EID;
	QSTCmpPosition	*position;
	QSTCmpSprite	*sprite;
	MutableVector2	*velocity;
}

@property (nonatomic,readonly) QSTCmpPosition *position;
@property (nonatomic,readonly) MutableVector2 *velocity;
@property (nonatomic,readonly) QSTCmpSprite *sprite;

-(id)initWithEID:(int)theEID position:(QSTCmpPosition*)thePos sprite:(QSTCmpSprite*)theSprite;

@end
