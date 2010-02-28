//
//  QSTCmpCollisionMap.h
//  Quest
//
//  Created by Per Borgman on 25/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface QSTCmpCollisionMap : NSObject {
	int					EID;
	NSMutableArray		*lines;
}

@property (nonatomic,readonly) NSMutableArray *lines;

-(id)initWithEID:(int)theEID;
-(void)debugDraw;

@end
