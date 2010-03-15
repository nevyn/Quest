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

@implementation QSTEntity

+(QSTEntity*)entityWithType:(NSString*)type {
	NSString *path = [NSString stringWithFormat:@"testgame/entities/%@.ent", type];
	
	NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONPath:path];
	
	NSDictionary *props = [QSTPropertyDB propertiesFromDictionary:r_root];
		
	QSTEntity *entity = [[[QSTEntity alloc] initWithProperties:props] autorelease];
	return entity;
}


-(id)initWithProperties:(NSDictionary*)props {
	if(self = [super init]) {
		properties = [props retain];
		[self printProperties];
	}
	return self;
}


-(void)dealloc {
	printf("FUUUUUUUU....!!!");
	[super dealloc];
}


-(void)printProperties {
	printf("Entity [%d] properties:\n", EID);
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
