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
@synthesize type;

+(QSTProperty*)propertyWithInt:(int)i {
	return [[[QSTProperty alloc] initWithInt:i] autorelease];
}

+(QSTProperty*)propertyWithVector:(MutableVector2*)v {
	return [[[QSTProperty alloc] initWithVector:v] autorelease];
}

+(QSTProperty*)propertyWithFloat:(float)f {
	return [[[QSTProperty alloc] initWithFloat:f] autorelease];
}

+(QSTProperty*)propertyWithString:(NSString*)s {
	return [[[QSTProperty alloc] initWithString:s] autorelease];
}

+(QSTProperty*)propertyWithBool:(BOOL)b {
	return [[[QSTProperty alloc] initWithBool:b] autorelease];
}

-(id)initWithInt:(int)i {
	if(self = [super init]) {
		type = QSTPropertyInt;
		data.intVal = i;
	}
	return self;
}

-(id)initWithVector:(MutableVector2*)v {
	if(self = [super init]) {
		type = QSTPropertyVector;
		MutableVector2 *vec = [[MutableVector2 vectorWithX:v.x y:v.y] retain];
		data.vectorVal = vec;
	}
	return self;
}

-(id)initWithFloat:(float)f {
	if(self = [super init]) {
		type = QSTPropertyFloat;
		data.floatVal = f;
	}
	return self;
}

-(id)initWithString:(NSString*)s {
	if(self = [super init]) {
		type = QSTPropertyString;
		data.stringVal = s;
		[s retain];
	}
	return self;
}

-(id)initWithBool:(BOOL)b {
	if(self = [super init]) {
		type = QSTPropertyBool;
		data.boolVal = b;
	}
	return self;
}

-(void)dealloc {
	//[name release];
	if(type == QSTPropertyVector) [data.vectorVal release];
	else if(type == QSTPropertyString) [data.stringVal release];
	[super dealloc];
}

-(int)intVal {
	return data.intVal;
}

-(float)floatVal {
	return data.floatVal;
}

-(MutableVector2*)vectorVal {
	return data.vectorVal;
}

-(NSString*)stringVal {
	return data.stringVal;
}

-(BOOL)boolVal {
	return data.boolVal;
}

-(void)setIntVal:(int)val {
	data.intVal = val;
}

-(void)setFloatVal:(float)val {
	data.floatVal = val;
}

-(void)setVectorVal:(MutableVector2*)val {
	if(data.vectorVal != val) [data.vectorVal release];
	data.vectorVal = [[MutableVector2 vectorWithX:val.x y:val.y] retain];
}

-(void)setStringVal:(NSString*)val {
	if(data.stringVal != val) [data.stringVal release];
	data.stringVal = [val retain];
}

-(void)setBoolVal:(BOOL)val {
	data.boolVal = val;
}

-(NSString*)valueAsString {
	if(type == QSTPropertyVector)
		return [NSString stringWithFormat:@"(%.3f, %.3f)", data.vectorVal.x, data.vectorVal.y];
	else if(type == QSTPropertyFloat)
		return [NSString stringWithFormat:@"%.3f", data.floatVal];
	else if(type == QSTPropertyString)
		return [NSString stringWithFormat:@"\"%@\"", data.stringVal];
	else if(type == QSTPropertyInt)
		return [NSString stringWithFormat:@"%d", data.intVal];
	else
		return data.boolVal ? @"true" : @"false";
}


@end
