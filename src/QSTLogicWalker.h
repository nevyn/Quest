//
//  QSTLogicWalker.h
//  Quest
//
//  Created by Per Borgman on 2010-03-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "QSTLogic.h"

@class QSTEntity;

@interface QSTLogicWalker : NSObject <QSTLogic> {
	QSTEntity	*owner;
}

-(id)initWithEntity:(QSTEntity*)entity;

-(void)tick:(float)delta;

@end
