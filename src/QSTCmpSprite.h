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
@class QSTResSprite;


@interface QSTCmpSprite : NSObject <QSTCmpGraphics> {
	int				EID;
	
	QSTCmpPosition	*position;
	
	NSString*		currentAnimation;
	int				currentFrame;
	
	QSTResSprite	*sprite;
}

@property (nonatomic,readonly) QSTResSprite* sprite;

-(id)initWithEID:(int)theEID name:(NSString*)spriteName position:(QSTCmpPosition*)thePosition;
-(void)render;

@end
