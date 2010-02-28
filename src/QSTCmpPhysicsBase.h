//
//  QSTCmpPhysicsBase.h
//  Quest
//
//  Created by Per Borgman on 26/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "QSTPhysicsSystem.h"

@interface QSTCmpPhysicsBase : NSObject {
	int					EID;
	
	QSTCmpPhysicsType	type;
}

@property (nonatomic,readonly) QSTCmpPhysicsType type;

-(id)initWithEID:(int)theEID type:(QSTCmpPhysicsType)theType;

@end
