//
//  JSONHelper.m
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JSONHelper.h"

#import "JSON.h"

@implementation JSONHelper


+(NSMutableDictionary*)dictionaryFromJSONPath:(NSString*)path {
	NSString *rawData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
	return [JSONHelper dictionaryFromJSONString:rawData];
}

+(NSMutableDictionary*)dictionaryFromJSONString:(NSString*)data {
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSMutableDictionary *root = [parser objectWithString:data];
	[parser release];	
	return root;
}

@end
