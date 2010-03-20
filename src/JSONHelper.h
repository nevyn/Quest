//
//  JSONHelper.h
//  Quest
//
//  Created by Per Borgman on 2010-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Vector2;

@interface JSONHelper : NSObject
+(NSMutableDictionary*)dictionaryFromJSONURL:(NSURL*)path;
+(NSMutableDictionary*)dictionaryFromJSONPath:(NSString*)path;
+(NSMutableDictionary*)dictionaryFromJSONString:(NSString*)data;

+(Vector2*)vectorFromKey:(NSString*)key data:(NSMutableDictionary*)data;

@end
