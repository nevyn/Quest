//
//  QSTEntity.m
//  Quest
//
//  Created by Per Borgman on 2010-03-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTEntity.h"

#import "JSON.h"
#import "QSTProperty.h"
#import "QSTPropertyDB.h"

@implementation QSTEntity

+(QSTEntity*)entityWithType:(NSString*)type {
	NSString *path = [NSString stringWithFormat:@"testgame/entities/%@.ent", type];
	NSString *rawData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
	
	printf("Entity: path: %s\n", [path UTF8String]);
	printf("Entity: json:\n%s\n", [rawData UTF8String]);
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSMutableDictionary *r_root = [parser objectWithString:rawData];
	[parser release];
	
	NSDictionary *properties = [QSTPropertyDB propertiesFromDictionary:r_root];
	
	QSTEntity *entity = [[[QSTEntity alloc] initWithProperties:properties] autorelease];
	return entity;
}


-(id)initWithProperties:(NSDictionary*)props {
	if(self = [super init]) {
		properties = [props retain];
		printf("Entity: inited with properties:\n");
		[self printProperties];
	}
	return self;
}


-(void)printProperties {
	for(NSString *key in properties) {
		printf("  %s:\t", [key UTF8String]);
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
