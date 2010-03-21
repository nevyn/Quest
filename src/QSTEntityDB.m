//
//  QSTEntityDB.m
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTEntityDB.h"

#import "JSONHelper.h"

#import "QSTPropertyDB.h"
#import "QSTEntity.h"

@interface QSTEntityDB ()
@property (assign) QSTCore *core;
@end


@implementation QSTEntityDB

@synthesize core;

-(id)initOnCore:(QSTCore*)core_ {
	if(![super init]) return nil;
	self.core = core_;
	entities = [[NSMutableArray alloc] init];
	return self;
}

-(void)dealloc {
	self.core = nil;
	[entities release];
	[super dealloc];
}

-(QSTEntity*)createEntityWithType:(NSString*)type
{
	NSURL *path = $joinUrls(core.gamePath, @"entities", [type stringByAppendingPathExtension:@"ent"]);
	
	NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONURL:path];
	
	// Return an Error Entity instead, that has a visible
	// debug sprite.
	if(r_root == nil) {
		printf("Warning: Unknown entity type %s\n", [type UTF8String]);
		return nil;
	}
	
	NSDictionary *props = [core.propertyDB propertiesFromDictionary:r_root];

	QSTEntity *entity = [[[QSTEntity alloc] initWithType:type EID:[entities count] properties:props] autorelease];
	[entities addObject:entity];
	return entity;
}

-(QSTEntity*)findEntityOfType:(NSString*)type {
	for(QSTEntity *entity in entities) {
		if([entity.type isEqualToString:type])
			return entity;
	}
	return nil;
}

-(void)removeEntity:(QSTEntity*)entity {
	[entities removeObject:entity];
}

@end
