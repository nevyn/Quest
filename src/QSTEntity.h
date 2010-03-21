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
	int					EID;
	NSString			*type;
	NSMutableDictionary	*properties;
}

@property (nonatomic,readonly) int EID;
@property (nonatomic,readonly) NSString *type;

-(id)initWithType:(NSString*)type_ EID:(int)eid_ properties:(NSDictionary*)props;

-(void)printProperties;
-(QSTProperty*)property:(NSString*)name;
-(void)setProperty:(NSString*)name to:(QSTProperty*)aProperty;
//-(void)sendEvent:(QSTEvent*)theEvent;

@end
