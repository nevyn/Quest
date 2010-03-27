//
//  QSTLogicPowerUp.h
//  Quest
//
//  Created by Per Borgman on 2010-03-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLogic.h"

@class QSTEntity;

@interface QSTLogicPowerUp : QSTLogic {

}

-(void)didCollideWith:(QSTEntity*)other;

@end
