//
//  QSTProperty.m
//  Quest
//
//  Created by Per Borgman on 2010-03-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTProperty.h"

#import "Vector2.h"

@implementation QSTProperty

+(QSTProperty*)propertyWithVector:(Vector2*)v {
	return [[QSTProperty alloc] initWithVector:v];
}

+(QSTProperty*)propertyWithFloat:(float)f {
	return [[QSTProperty alloc] initWithFloat:f];
}

+(QSTProperty*)propertyWithString:(NSString*)s {
	return [[QSTProperty alloc] initWithString:s];
}

-(QSTProperty*)initWithVector:(Vector2*)v {
	if(self = [super init]) {
		type = 0;
		Vector2 *vec = [[Vector2 vectorWithX:v.x y:v.y] retain];
		data.vectorVal = vec;
	}
	return self;
}

-(QSTProperty*)initWithFloat:(float)f {
	if(self = [super init]) {
		type = 1;
		data.floatVal = f;
	}
	return self;
}

-(id)initWithString:(NSString*)s {
	if(self = [super init]) {
		type = 2;
		data.stringVal = s;
		[s retain];
	}
	return self;
}

-(void)print {
	if(type == 0)
		printf(" v: %f %f", data.vectorVal.x, data.vectorVal.y);
	else if(type == 1)
		printf(" f: %f", data.floatVal);
	else
		printf(" s: %s", [data.stringVal UTF8String]);
}


@end
