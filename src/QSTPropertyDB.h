//
//  QSTPropertyDB.h
//  Quest
//
//  Created by Per Borgman on 2010-03-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTProperty;
@class QSTCore;

@interface QSTPropertyDB : NSObject {
	QSTCore *core;
	NSMutableDictionary *componentTemplates;
}
+(QSTProperty*)propertyWithName:(NSString*)type data:(id)data;

-(id)initOnCore:(QSTCore*)core_;
-(NSDictionary*)propertiesFromDictionary:(NSDictionary*)data;

@end
