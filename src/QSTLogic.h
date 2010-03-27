//
//  QSTLogic.h
//  Quest
//
//  Created by Per Borgman on 2010-03-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
	There should be lots of callback-methods for logic classes
    to implement.
 
	examples:
	== Physics ==
	onDamagedBy:()other
	shouldCollideWith:()other
    onCollisionWith:()other
	aboutToFall?
 
 
	customEvent:(event)
*/
 

@class QSTEntity;
@class QSTGame;

@interface QSTLogic : NSObject {
	QSTGame		*game;
	QSTEntity	*owner;
}
@property (nonatomic,readonly) QSTGame *game;
@property (nonatomic,readonly) QSTEntity *owner;

-(id)initWithGame:(QSTGame*)game_ owner:(QSTEntity*)owner_;

@end



/*
@protocol QSTLogic

-(id)initWithEntity:(QSTEntity*)entity;
-(void)tick:(float)delta;

@end
*/