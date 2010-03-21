//
//  QSTEntityDB.h
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "QSTCore.h"

@class QSTEntity;

@interface QSTEntityDB : NSObject {
	QSTCore	*core;
	
	NSMutableArray	*entities;
}

-(id)initOnCore:(QSTCore*)core_;

-(QSTEntity*)createEntityWithType:(NSString*)type;

-(QSTEntity*)findEntityOfType:(NSString*)type;
-(void)removeEntity:(QSTEntity*)entity;

@end
