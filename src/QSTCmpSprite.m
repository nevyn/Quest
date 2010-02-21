//
//  QSTCmpSprite.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTCmpSprite.h"


@implementation QSTCmpSprite

-(id)initWithEID:(int)theEID {
	if(self = [super init]) {
		EID = theEID;
	}
	return self;
}

@end
