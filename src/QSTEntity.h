//
//  QSTEntity.h
//  Quest
//
//  Created by Per Borgman on 2010-03-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTProperty;
@class QSTCore;

/*
	Entity
 
	Proxy/helper class for entities.
	Are created by EntityDB.
*/

@interface QSTEntity : NSObject {
	int				EID;
	NSMutableDictionary	*properties;
}

+(QSTEntity*)entityWithType:(NSString*)type inCore:(QSTCore*)core;

-(id)initWithProperties:(NSDictionary*)props;

-(void)printProperties;
-(QSTProperty*)property:(NSString*)name;
-(void)setProperty:(NSString*)name to:(QSTProperty*)aProperty;
//-(void)sendEvent:(QSTEvent*)theEvent;

@end
