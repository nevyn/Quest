//
//  QSTEntityTemplate.h
//  Quest
//
//  Created by Per Borgman on 28/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
	QSTTemplateNodeTypeNode,
	QSTTemplateNodeTypeEmpty,
	QSTTemplateNodeTypeString,
	QSTTemplateNodeTypeVector
} QSTTemplateNodeType;

@interface QSTTemplateNode : NSObject {
	NSString	*name;
	
	QSTTemplateNodeType	*type;
	
	NSString	*dataString;
	Vector2		*dataVector;
	NSArray		*dataChildren;
}

+(QSTTemplateNode*)initWithDictionary:(NSMutableDictionary*)dict;
-(id)initWithType:(QSTTemplateNodeType)tType;
-(QSTTemplateNode*)getDeepCopy;

@end

/*
 
	root - array
 
		[0] - Name: "Position", Vector
		[1] - Name: "Physics", Parent
		[2] - Name: "Sprite", string
 
 */

@interface QSTResEntityTemplate : NSObject {
	//NSMutableDictionary *components;
	
	QSTTemplateNode	*root;
}

@property (nonatomic,readonly) NSMutableDictionary *components;

-(id)initWithName:(NSString*)name;
-(id)initWithComponents:(NSMutableDictionary*)theComps;

-(QSTResEntityTemplate*)templateOverriddenWith:(QSTResEntityTemplate*)other;
-(void)instantiate;	// Create a concrete entity

@end
