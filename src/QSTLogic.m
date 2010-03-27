//
//  QSTLogic.m
//  Quest
//
//  Created by Per Borgman on 2010-03-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLogic.h"

@interface QSTLogic()
@property (nonatomic,readwrite,retain) QSTGame *game;
@property (nonatomic,readwrite,retain) QSTEntity *owner;
@end

@implementation QSTLogic
@synthesize game, owner;

-(id)initWithGame:(QSTGame*)game_ owner:(QSTEntity*)owner_ {
	if(![super init]) return nil;
	
	self.game = game_;
	self.owner = owner_;
	
	return self;
}

-(void)dealloc {
	self.game = nil;
	self.owner = nil;
	[super dealloc];
}

@end
