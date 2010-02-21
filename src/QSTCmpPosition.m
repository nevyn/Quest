//
//  QSTCmpPosition.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCmpPosition.h"

#import "Vector2.h"

@implementation QSTCmpPosition

@synthesize position;

-(id)initWithEID:(int)theEID {
	if(self = [super init]) {
		EID = theEID;
		position = [[MutableVector2 alloc] init];
	}
	return self;
}

@end
