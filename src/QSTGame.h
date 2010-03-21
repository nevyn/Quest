//
//  QSTGame.h
//  Quest
//
//  Created by Per Borgman on 2010-03-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QSTCore;
@class QSTEntity;

@interface QSTGame : NSObject {
	
	QSTCore			*core;

	// QSTPowerUp?
	// - Coolt, kan ha unik callbackkod:
	//   onBeginFrame
	//	 onPlayerAction:(??)action;
	// 
	// Bara enkel enum/strängar?
	// - Spelet frågar när det behövs
	NSMutableArray	*powerUps;
	
	QSTEntity		*playerEntity;
	
}

-(id)initOnCore:(QSTCore*)core_;

-(void)loadArea:(NSString*)areaName;
-(void)loadLayer:(NSMutableDictionary*)layerData withIndex:(int)theIndex;
-(QSTEntity*)createEntity:(NSMutableDictionary*)data layer:(int)layerIndex;

-(void)leftStart;
-(void)leftStop;
-(void)rightStart;
-(void)rightStop;
-(void)jump;
-(void)shoot;

@end
