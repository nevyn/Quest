//
//  QSTNetSocket.h
//  Quest
//
//  Created by Joachim Bengtsson on 2010-03-21.
//  Copyright 2010 Third Cog Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AsyncSocket.h"

// Thin wrapper around AsyncSocket abstracting sending and receiving 
// objc objects. A QSTNetSocketDelegate is expected to implement
// the same interface as an AsyncSocketDelegate.
// To get the QSTNetSocket from an AsyncSocketDelegate call, cast its userData to
// QSTNetSocket.

@class QSTNetSocket;
@protocol QSTNetSocketDelegate
@required
-(void)netSocket:(QSTNetSocket*)sck didReceiveCommand:(NSString*)cmd attachment:(id)obj;
@end


@interface QSTNetSocket : NSObject {
	AsyncSocket *socket;
	NSObject<QSTNetSocketDelegate> *delegate;
	uint32_t commandLength;
}
@property (nonatomic,readonly,retain) AsyncSocket *socket;
@property (nonatomic,assign) NSObject<QSTNetSocketDelegate> *delegate;
-(id)initWithConnectedSocket:(AsyncSocket*)sck;
-(void)sendCommand:(NSString*)cmd attachment:(id)obj;
@end
