//
//  QSTPropertyDB.h
//  Quest
//
//  Created by Per Borgman on 2010-03-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTProperty;

@interface QSTPropertyDB : NSObject {

}

//-(QSTProperty*)propertyWithName:(NSString*)name forEntity:(int)tEID;

+(QSTProperty*)propertyFromName:(NSString*)type data:(id)data;
+(NSDictionary*)propertiesFromDictionary:(NSDictionary*)data;

@end
