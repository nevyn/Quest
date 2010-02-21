//
//  QSTCmpPhysics.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class QSTCmpPosition;
@class MutableVector2;


@interface QSTCmpPhysics : NSObject {
	int				EID;
	
	QSTCmpPosition	*position;
	
	MutableVector2	*velocity;
}

@property (nonatomic,readonly) QSTCmpPosition *position;
@property (nonatomic,readonly) MutableVector2 *velocity;

-(id)initWithEID:(int)theEID position:(QSTCmpPosition*)thePos;

@end
