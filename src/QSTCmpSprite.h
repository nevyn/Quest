//
//  QSTCmpSprite.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "QSTGraphicsSystem.h"


@class QSTCmpPosition;


@interface QSTCmpSprite : NSObject <QSTCmpGraphics> {
	int				EID;
	
	QSTCmpPosition	*position;
}

-(id)initWithEID:(int)theEID position:(QSTCmpPosition*)thePosition;
-(void)render;

@end
