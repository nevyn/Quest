//
//  QSTCmpPhysicsBase.m
//  Quest
//
//  Created by Per Borgman on 26/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCmpPhysicsBase.h"


@implementation QSTCmpPhysicsBase

@synthesize type;

-(id)initWithEID:(int)theEID type:(QSTCmpPhysicsType)theType {
	if(self = [super init]) {
		EID = theEID;
		type = theType;
	}
	return self;
}

@end
