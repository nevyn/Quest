//
//  QSTLogicsSystem.m
//  Quest
//
//  Created by Per Borgman on 2010-03-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLogicsSystem.h"

@interface QSTLogicsSystem ()
@property (nonatomic,assign) QSTCore *core;
@end

@implementation QSTLogicsSystem
@synthesize core;

-(id)initOnCore:(QSTCore*)core_ {
	if(![super init]) return nil;
	self.core = core_;
	return self;
}

-(void)registerEntity:(QSTEntity*)entity {
}

@end
