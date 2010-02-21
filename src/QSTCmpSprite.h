//
//  QSTCmpSprite.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface QSTCmpGraphics : NSObject {
}
@end

@implementation QSTCmpGraphics
@end



@interface QSTCmpSprite : QSTCmpGraphics {
	int	EID;
}

-(id)initWithEID:(int)theEID;

@end
