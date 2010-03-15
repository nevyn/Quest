//
//  QSTResourceDB.h
//  Quest
//
//  Created by Per Borgman on 21/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTResTexture;
@class QSTResSprite;
//@class QSTResEntityTemplate;

@interface QSTResourceDB : NSObject {

}

+(QSTResTexture*)getTextureWithPath:(NSString*)path;
+(QSTResSprite*)getSpriteWithName:(NSString*)name;
//+(QSTResEntityTemplate*)getEntityTemplateWithName:(NSString*)name;

@end
