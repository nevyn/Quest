//
//  QSTCmpPosition.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class MutableVector2;


@interface QSTCmpPosition : NSObject {
	int				EID;
	
	MutableVector2	*position;
}

@property (nonatomic,readonly) MutableVector2 *position;

-(id)initWithEID:(int)theEID;

@end
