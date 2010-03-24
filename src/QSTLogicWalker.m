//
//  QSTLogicWalker.m
//  Quest
//
//  Created by Per Borgman on 2010-03-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLogicWalker.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

#import "Vector2.h"

@implementation QSTLogicWalker

-(id)initWithEntity:(QSTEntity*)entity {
	if(![super init]) return nil;
	owner = entity;
	return self;
}

-(void)tick:(float)delta {
	QSTProperty *vel = [owner property:@"Velocity"];
	[vel vectorVal].x = 1.0f;
}

@end
