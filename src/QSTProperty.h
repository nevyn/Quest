//
//  QSTProperty.h
//  Quest
//
//  Created by Per Borgman on 2010-03-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Vector2;

@interface QSTProperty : NSObject {
	int type;
	NSString *name;
	
	union {
		float		floatVal;
		Vector2*	vectorVal;
		NSString*	stringVal;
	} data;
}

+(QSTProperty*)propertyWithVector:(Vector2*)v;
+(QSTProperty*)propertyWithFloat:(float)f;
+(QSTProperty*)propertyWithString:(NSString*)s;

-(id)initWithVector:(Vector2*)v;
-(id)initWithFloat:(float)f;
-(id)initWithString:(NSString*)s;

-(void)print;

@end
