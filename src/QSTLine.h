//
//  QSTLine.h
//  Quest
//
//  Created by Per Borgman on 23/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Vector2;

@interface QSTLine : NSObject {
	Vector2	*a;
	Vector2 *b;
	
	Vector2 *normal;
}

@property (nonatomic,readonly) Vector2 *a;
@property (nonatomic,readonly) Vector2 *b;
@property (nonatomic,readonly) Vector2 *normal;

+(QSTLine*)lineWithA:(Vector2*)ta b:(Vector2*)tb;

-(id)initWithX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2;
-(id)initWithA:(Vector2*)ta b:(Vector2*)tb;

-(Vector2*)intersects:(QSTLine*)other;

@end
