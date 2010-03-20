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
#import "JSONHelper.h"

static NSMutableDictionary *componentTemplates;

@implementation QSTPropertyDB

+(void)initialize {
	printf("PropertyDB: Initializing!\n");
	
	componentTemplates = [[NSMutableDictionary dictionary] retain];
	
	NSFileManager *fm = [[NSFileManager alloc] init];
	NSArray *files = [fm contentsOfDirectoryAtPath:@"testgame/components" error:NULL];
	for(NSString *filename in files) {
		NSString *fullpath = [@"testgame/components/" stringByAppendingString:filename];
		printf("Reading %s...\n", [fullpath UTF8String]);
				
		NSMutableDictionary *r_root = [JSONHelper dictionaryFromJSONPath:fullpath];
		
		NSString *r_name = [r_root objectForKey:@"name"];
		NSMutableDictionary *r_props = [r_root objectForKey:@"properties"];
		
		[componentTemplates setObject:r_props forKey:r_name];
	}
	[fm release];
}


+(QSTProperty*)propertyWithName:(NSString*)type data:(id)data {
	// Data can be of:
	// - float
	// - (int)
	// - array (vector2)
	// - string
	if([data isKindOfClass:[NSArray class]]) {
		NSArray *data_array = (NSArray*)data;
		MutableVector2 *val = [MutableVector2 vectorWithX:[[data_array objectAtIndex:0] floatValue] 
														y:[[data_array objectAtIndex:1] floatValue]];
		
		return [QSTProperty propertyWithVector:val];
	} else if ([data isKindOfClass:[NSString class]]) {
		return [QSTProperty propertyWithString:data];
	} else {
		float val = [data floatValue];
		return [QSTProperty propertyWithFloat:val];
	}
}


+(NSDictionary*)propertiesFromDictionary:(NSDictionary*)data {
	NSMutableDictionary *resultProps = [NSMutableDictionary dictionary];
	for(NSString *key in data) {
		printf(" Check %s...", [key UTF8String]);
		
		// If it's a component
		NSDictionary *compProperties = [componentTemplates objectForKey:key];
		if(compProperties != nil) {
			printf("Component\n");
			NSDictionary *overrides = [data objectForKey:key];
			for(NSString *compKey in compProperties) {
				if([overrides objectForKey:compKey] != nil)
					[resultProps setObject:[QSTPropertyDB propertyWithName:compKey data:[overrides objectForKey:compKey]] 
									forKey:compKey];
				else
					[resultProps setObject:[QSTPropertyDB propertyWithName:compKey data:[compProperties objectForKey:compKey]]
									forKey:compKey];
			}
			
		// Otherwise it's a normal property
		} else {
			printf("Property\n");
			[resultProps setObject:[QSTPropertyDB propertyWithName:key data:[data objectForKey:key]]
							forKey:key];
		}

	}
	return resultProps;
}

@end
