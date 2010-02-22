//
//  QSTResSprite.m
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTResSprite.h"

#import "QSTResourceDB.h"

@implementation QSTResSprite

-(id)initWithTexture:(NSString*)tex {
	if(self = [super init]) {
		texture = [QSTResourceDB getTextureWithName:tex];
	}
	return self;
}

-(void)use {
	[texture use];
}

@end
