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
		[self printProperties];
	}
	return self;
}


-(void)dealloc {
	[properties release];
	[type release];
	[super dealloc];
}


-(void)printProperties {
	printf("Entity [%d] (%s) properties:\n", EID, [type UTF8String]);
	for(NSString *key in properties) {
		printf("  %16s: ", [key UTF8String]);
		[((QSTProperty*)[properties objectForKey:key]) print];
		printf("\n");
	}
}


-(QSTProperty*)property:(NSString*)name {
	return [properties objectForKey:name];
}


-(void)setProperty:(NSString*)name to:(QSTProperty*)aProperty {
	//QSTProperty *p = [properties objectForKey:name];
	//if(p != nil && p->type != aProperty->type) {
		// Warning: Replacing property with property of different type
	//}
	[properties setObject:aProperty forKey:name];
}

//-(void)sendEvent:(QSTEvent*)theEvent {
//}

@end
