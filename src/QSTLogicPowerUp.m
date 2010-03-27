//
//  QSTLogicPowerUp.m
//  Quest
//
//  Created by Per Borgman on 2010-03-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLogicPowerUp.h"

#import "QSTGame.h"
#import "QSTEntity.h"
#import "QSTProperty.h"

@implementation QSTLogicPowerUp

-(void)didCollideWith:(QSTEntity*)other {
	if(other != game.playerEntity) return;
	
	QSTProperty *powerup = [owner property:@"PowerUp"];
	[game givePowerUp:[powerup stringVal]];
	
	[owner remove];
}

@end
