//
//  QSTBoundingBox.h
//  Quest
//
//  Created by Per Borgman on 22/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Vector2;

@interface QSTBoundingBox : NSObject {
	Vector2	*min;
	Vector2	*max;
}

@property (nonatomic,readonly) Vector2 *min;
@property (nonatomic,readonly) Vector2 *max;

+(id)bboxWithMinX:(float)minX minY:(float)minY maxX:(float)maxX maxY:(float)maxY;

-(id)initWithMinX:(float)minX minY:(float)minY maxX:(float)maxX maxY:(float)maxY;

@end
