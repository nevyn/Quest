//
//  QSTNetSocket.m
//  Quest
//
//  Created by Joachim Bengtsson on 2010-03-21.
//  Copyright 2010 Third Cog Software. All rights reserved.
//

#import "QSTNetSocket.h"
#import "CollectionUtils.h"

@interface QSTNetSocket ()
@property (nonatomic,readwrite,retain) AsyncSocket *socket;
@end

typedef enum {
	WaitForCommandLength,
	WaitForCommand,
} States;


@implementation QSTNetSocket
@synthesize socket, delegate;
-(id)initWithConnectedSocket:(AsyncSocket*)sck;
{
	if(![super init]) return nil;
	self.socket = sck;
	self.socket.delegate = self;
	self.socket.userData = (long)self;
	return self;
}
-(void)dealloc;
{
	self.delegate = nil;
	if(self.socket.delegate == self)
		self.socket.delegate = nil;
	self.socket = nil;
	[super dealloc];
}
-(void)sendCommand:(NSString*)cmd attachment:(id)obj;
{
	NSDictionary *d = $dict(
		@"c", cmd,
		@"a", obj
	);
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:d];
	uint32_t length = [data length];
	length = OSSwapHostToBigInt32(length);
	[socket writeData:[NSData dataWithBytes:&length length:4] withTimeout:-1 tag:0];
	[socket writeData:data									  						    withTimeout:-1 tag:0];
}


- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
	if([delegate respondsToSelector:@selector(onSocketDidDisconnect:)])
		[delegate onSocketDidDisconnect:sock];
	self.socket = nil;
}
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err;
{
	if([delegate respondsToSelector:@selector(onSocket:willDisconnectWithError:)])
		[delegate onSocket:sock willDisconnectWithError:err];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	if([delegate respondsToSelector:@selector(onSocket:didConnectToHost:post:)])
		[delegate onSocket:sock didConnectToHost:host port:port];
	[socket readDataToLength:4 withTimeout:-1 tag:WaitForCommandLength];
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	if([delegate respondsToSelector:@selector(onSocket:didReadData:withTag:)])
		[delegate onSocket:sock didReadData:data withTag:tag];

	switch (tag) {
		case WaitForCommandLength:
			[data getBytes:&commandLength length:4];
			commandLength = OSSwapBigToHostInt32(commandLength);
			[socket readDataToLength:commandLength withTimeout:-1 tag:WaitForCommand];
			break;
		case WaitForCommand: {
			NSDictionary *command = [NSKeyedUnarchiver unarchiveObjectWithData:data];
			NSString *c = [command objectForKey:@"c"];
			id attachment = [command objectForKey:@"a"];
			[delegate netSocket:self didReceiveCommand:c attachment:attachment];
			[socket readDataToLength:4 withTimeout:-1 tag:WaitForCommandLength];
			break;
		}
	}
}

// Ugh, I'm much too lazy to implement forwarders for the rest of the callbacks.
// I'm just going to have to be very mad at myself some time in the future.
@end
