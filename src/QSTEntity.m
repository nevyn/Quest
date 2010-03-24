//
//  QSTEntity.m
//  Quest
//
//  Created by Per Borgman on 2010-03-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTEntity.h"

#import "JSONHelper.h"
#import "QSTProperty.h"
#import "QSTPropertyDB.h"
#import "QSTCore.h"

#import "QSTLog.h"

@implementation QSTEntity

@synthesize EID, type;

-(id)initWithEID:(int)eid_ {
	if(![super init]) return nil;
	EID = eid_;
	type = @"__custom";
	properties = [[NSMutableDictionary alloc] init];
	return self;
}


-(id)initWithType:(NSString*)type_ EID:(int)eid_ properties:(NSDictionary*)props {
	if(self = [super init]) {
		EID = eid_;
		type = [type_ retain];
		properties = [props retain];
	}
	return self;
}


-(void)dealloc {
	[properties release];
	[type release];
	[super dealloc];
}


-(void)printPropertiesToLogger:(NSString*)loggerName {
	Debug(loggerName, @"Entity [%d] (%@) properties:", EID, type);
	for(NSString *key in properties) {
		Debug(loggerName, @"  %@: %@", key, [(QSTProperty*)[properties objectForKey:key] valueAsString]);
	}
}


-(QSTProperty*)property:(NSString*)name {
	return [properties objectForKey:name];
}


-(void)setProperty:(NSString*)name to:(QSTProperty*)aProperty {
	QSTProperty *p = [properties objectForKey:name];
	if(p != nil && p.type != aProperty.type)
		Warning(@"Engine", @"Entity: Replacing property '%@' with property of different type.", name);
	[properties setObject:aProperty forKey:name];
}


//-(void)sendEvent:(QSTEvent*)theEvent {
//}

@end
