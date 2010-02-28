//
//  QSTCmpPhysics.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCmpPhysics.h"

#import "Vector2.h"

@implementation QSTCmpPhysics

@synthesize position;
@synthesize velocity;
@synthesize sprite;

-(id)initWithEID:(int)theEID position:(QSTCmpPosition*)thePos sprite:(QSTCmpSprite*)theSprite {
	if(self = [super init]) {
		EID = theEID;
		position = [thePos retain];
		sprite = [theSprite retain];
		velocity = [[MutableVector2 alloc] init];
	}
	return self;
}

@end
