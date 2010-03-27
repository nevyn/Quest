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
	// - Coolt, kan ha unik callbackkod, blir mer som mutators i UT:
	//   onBeginFrame
	//	 onPlayerAction:(??)action;
	// - svårt, måste ha callbacks så man kan göra vad som helst.
	//   - High jump
	//   - Ge missiler
	//   - Springa snabbt
	//   - Bomber
	//   - X-ray
	// 
	// Bara enkel enum/strängar?
	// - Spelet frågar när det behövs
	NSMutableArray	*powerUps;
	NSMutableArray	*globals;	// Properties
	
	QSTEntity		*playerEntity;
	
}

@property (nonatomic,readonly) QSTEntity *playerEntity;

-(id)initOnCore:(QSTCore*)core_;

-(void)loadArea:(NSString*)areaName;
-(void)loadLayer:(NSMutableDictionary*)layerData withIndex:(int)theIndex;
-(QSTEntity*)createEntity:(NSMutableDictionary*)data layer:(int)layerIndex;

-(void)givePowerUp:(NSString*)puName;

-(void)leftStart;
-(void)leftStop;
-(void)rightStart;
-(void)rightStop;
-(void)jump;
-(void)shoot;

@end
