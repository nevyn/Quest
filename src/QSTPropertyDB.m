//
//  QSTPropertyDB.m
//  Quest
//
//  Created by Per Borgman on 2010-03-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTPropertyDB.h"

#import "QSTProperty.h"
#import "Vector2.h"
#import "JSON.h"

static NSMutableDictionary *componentTemplates;

@implementation QSTPropertyDB

+(void)initialize {
	componentTemplates = [[NSMutableDictionary dictionary] retain];
	
	NSFileManager *fm = [[NSFileManager alloc] init];
	NSArray *files = [fm contentsOfDirectoryAtPath:@"testgame/components" error:NULL];
	for(NSString *filename in files) {
		NSString *fullpath = [@"testgame/components/" stringByAppendingString:filename];
		printf("Reading %s...\n", [fullpath UTF8String]);
		
		NSString *raw = [NSString stringWithContentsOfFile:fullpath encoding:NSUTF8StringEncoding error:NULL];
		
		SBJsonParser *parser = [[SBJsonParser alloc] init];
		NSMutableDictionary *r_root = [parser objectWithString:raw];
		[parser release];
		
		NSString *r_name = [r_root objectForKey:@"name"];
		NSMutableDictionary *r_props = [r_root objectForKey:@"properties"];
		
		[componentTemplates setObject:r_props forKey:r_name];
	}
}


+(QSTProperty*)propertyFromName:(NSString*)type data:(id)data {
	// Data can be of:
	// - float
	// - (int)
	// - array (vector2)
	if([data isKindOfClass:[NSArray class]]) {
		NSArray *data_array = (NSArray*)data;
		MutableVector2 *val = [MutableVector2 vectorWithX:[[data_array objectAtIndex:0] floatValue] 
														y:[[data_array objectAtIndex:1] floatValue]];
		
		return [[QSTProperty propertyWithVector:val] autorelease];
	} else if ([data isKindOfClass:[NSString class]]) {
		return [[QSTProperty propertyWithString:data] autorelease];
	} else {
		float val = [data floatValue];
		return [[QSTProperty propertyWithFloat:val] autorelease];
	}
}


+(NSDictionary*)propertiesFromDictionary:(NSDictionary*)data {
	NSMutableDictionary *resultProps = [[NSMutableDictionary dictionary] autorelease];
	for(NSString *key in data) {
		printf(" Check %s...", [key UTF8String]);
		
		// If it's a component
		NSDictionary *compProperties = [componentTemplates objectForKey:key];
		if(compProperties != nil) {
			printf("Component\n");
			NSDictionary *overrides = [data objectForKey:key];
			for(NSString *compKey in compProperties) {
				if([overrides objectForKey:compKey] != nil)
					[resultProps setObject:[QSTPropertyDB propertyFromName:compKey data:[overrides objectForKey:compKey]] 
									forKey:compKey];
				else
					[resultProps setObject:[QSTPropertyDB propertyFromName:compKey data:[compProperties objectForKey:compKey]]
									forKey:compKey];
			}
			
		// Otherwise it's a normal property
		} else {
			printf("Property\n");
			[resultProps setObject:[QSTPropertyDB propertyFromName:key data:[data objectForKey:key]]
							forKey:key];
		}

	}
	return resultProps;
}

@end
