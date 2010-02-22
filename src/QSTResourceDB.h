//
//  QSTResourceDB.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTResSprite;

@interface QSTResourceDB : NSObject {

}

+(QSTResSprite*)getSpriteWithName:(NSString*)name;

@end
