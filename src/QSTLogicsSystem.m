//
//  QSTLogicsSystem.m
//  Quest
//
//  Created by Per Borgman on 2010-03-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLogicsSystem.h"

#import "QSTEntity.h"
#import "QSTProperty.h"

#import "QSTLogic.h"

#import "QSTLog.h"

@interface QSTLogicsSystem ()
@property (nonatomic,assign) QSTCore *core;
@end

@implementation QSTLogicsSystem
@synthesize core;

-(id)initOnCore:(QSTCore*)core_ {
	if(![super init]) return nil;
	
	Info(@"Engine", @"-------- Initializing Logics System --------");
	
	self.core = core_;
	logics = [[NSMutableArray alloc] init];
	return self;
}

-(void)registerEntity:(QSTEntity*)entity {
	QSTProperty *logicname = [entity property:@"Logic"];
	if(!logicname) return;
	
	NSString *classname = [@"QSTLogic" stringByAppendingString:[logicname stringVal]];
	id logic = [[NSClassFromString(classname) alloc] initWithEntity:entity];
	[logics addObject:logic];
	[logic release];
}

-(void)tick:(float)delta {
	for(id logic in logics)
		[logic tick:delta];
}

@end
