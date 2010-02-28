//
//  QSTLine.m
//  Quest
//
//  Created by Per Borgman on 23/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLine.h"

#import "Vector2.h"

@implementation QSTLine

@synthesize a;
@synthesize b;
@synthesize normal;

-(id)initWithX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 {
	if(self = [super init]) {
		a = [[Vector2 vectorWithX:x1 y:y1] retain];
		b = [[Vector2 vectorWithX:x2 y:y2] retain];
		
		float vx = x2 - x1;
		float vy = y2 - y1;
		
		float nx = vy;
		float ny = -vx;
		
		normal = [[[Vector2 vectorWithX:nx y:ny] normalizedVector] retain];
	}
	return self;
}

-(id)initWithA:(Vector2*)ta b:(Vector2*)tb {
	return [self initWithX1:ta.x y1:ta.y x2:tb.x y2:tb.y];
}

#define EPSILON 0.001f

#define EPSILON_MIN -0.0f
#define EPSILON_MAX 1.0f

-(Vector2*)intersects:(QSTLine*)other {
	Vector2 *v1 = [b vectorBySubtractingVector:a];
	/*Vector2 *v2 = [other.b vectorBySubtractingVector:other.a];
	
	if(v2.y == 0.0f) {
		printf("horizontal\n");
		printf("  %f %f  ->  %f %f\n", a.x, a.y, b.x, b.y);
		printf("  %f %f  ->  %f %f\n", other.a.x, other.a.y, other.b.x, other.b.y);
	}*/
	
	float den = ((other.b.y - other.a.y) * (b.x - a.x)) - ((other.b.x - other.a.x) * (b.y - a.y));
		
	// Parallel
	if(den > -EPSILON && den < EPSILON) { 
		//printf("%f %f was parallel to %f %f\n", v1.x, v1.y, v2.x, v2.y);
		return nil; 
	}
		
	float t1 = ((other.b.x - other.a.x) * (a.y - other.a.y)) - ((other.b.y - other.a.y) * (a.x - other.a.x));
	float t2 = ((b.x - a.x) * (a.y - other.a.y)) - ((b.y - a.y) * (a.x - other.a.x));
	
	float ua = t1 / den;
	float ub = t2 / den;
		
	// Outside of segment
	if(ua < EPSILON_MIN || ua > EPSILON_MAX || ub < EPSILON_MIN || ub > EPSILON_MAX) return nil;
		
	Vector2 *res = [a vectorByAddingVector:[v1 vectorByMultiplyingWithScalar:ua]];
	
	return res;
}

@end
