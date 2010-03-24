//
//  QSTLogic.h
//  Quest
//
//  Created by Per Borgman on 2010-03-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTEntity;

@protocol QSTLogic

-(id)initWithEntity:(QSTEntity*)entity;
-(void)tick:(float)delta;

@end
