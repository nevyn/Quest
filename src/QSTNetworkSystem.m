//
//  QSTNetworkSystem.m
//  Quest
//
//  Created by Joachim Bengtsson on 2010-03-20.

#import "QSTNetworkSystem.h"
#import "QSTNetSocket.h"

static const int QSTServerPort = 15983;

@interface QSTNetworkSystem ()
@property (nonatomic,assign) QSTCore *core;
@end

@implementation QSTNetworkSystem
@synthesize core;
-(id)initOnCore:(QSTCore*)core_;
{
	if(![super init]) return nil;
	self.core = core_;
		
	return self;
}
-(void)dealloc;
{
	self.core = nil;
}
@end

@interface QSTClientNetworkSystem ()
@property (nonatomic,retain) QSTNetSocket *socket;
@end


@implementation QSTClientNetworkSystem
@synthesize host, socket;
-(id)initOnCore:(QSTCore*)core_;
{
	if(![super initOnCore:core_]) return nil;
	
	[self addObserver:self
				 forKeyPath:@"host"
						options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
						context:0];
	
	return self;
}
-(void)dealloc;
{
	self.host = nil;
	[self removeObserver:self forKeyPath:@"host"];
	[super dealloc];
}

-(void)disconnect;
{
	[socket.socket disconnect];
	self.socket = nil;
}
-(void)connect;
{
	[self disconnect];
	AsyncSocket *realSock = [[[AsyncSocket alloc] initWithDelegate:nil] autorelease];
	[realSock setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];

	NSError *err = nil;
	if(![realSock connectToHost:host onPort:QSTServerPort error:&err]) {
		NSLog(@"QSTClientNetworkSystem: Connection error: %@", [err localizedDescription]);
		// Tell our delegate
		return;
	}

	self.socket = [[[QSTNetSocket alloc] initWithConnectedSocket:realSock] autorelease];
	self.socket.delegate = self;

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)ctx
{
	if(![keyPath isEqual:@"host"] && object != self) // Not our kvo
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:ctx];
		
	if([[change objectForKey:NSKeyValueChangeOldKey] isEqual:[change objectForKey:NSKeyValueChangeNewKey]]) // Nothing changed
		return;
	
	if(!host)
		[self disconnect];
	else
		[self connect];
}

-(void)netSocket:(QSTNetSocket*)sck didReceiveCommand:(NSString*)cmd attachment:(id)obj;
{
	// TODO: Actually doing something.
}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
	// TODO: Tell our delegate
}

@end


@interface QSTServerNetworkSystem ()
@property (nonatomic,retain) AsyncSocket *listen;
@property (nonatomic,retain) NSMutableArray *clients;
@end



@implementation QSTServerNetworkSystem
@synthesize listen, clients;
-(id)initOnCore:(QSTCore*)core_;
{
	if(![super initOnCore:core_]) return nil;
	
	clients = [NSMutableArray new];
	
	listen  = [[AsyncSocket alloc] initWithDelegate:self];
	[listen setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
	
	NSError *err;
	if(![listen acceptOnPort:QSTServerPort error:&err]) {
		NSLog(@"%@", err);
		[self release];
		return nil;	
	}	
	
	return self;
}
-(void)dealloc;
{
	self.clients = nil;
	[self.listen disconnect];
	self.listen = nil;
	[super dealloc];
}

-(void)processNewClient:(QSTNetSocket*)sck;
{
	// Send the game state to 'im
}
-(void)netSocket:(QSTNetSocket*)sck didReceiveCommand:(NSString*)cmd attachment:(id)obj;
{
	// TODO: Actually doing something.
}

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
	[sock setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
	QSTNetSocket *client = [[QSTNetSocket alloc] initWithConnectedSocket:sock];
	client.delegate = self;
	// Don't want to add the client to clients until the socket is properly connected.
	// The memory isn't lost; we will get either a connection or disconnection error.
}
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err;
{
	// TODO: proper error handling
	if(sock == listen) {
		NSLog(@"QSTServerNetworkSystem: listen socket error: %@", [err localizedDescription]);
	} else {
		NSLog(@"QSTServerNetworkSystem: client socket error: %@", [err localizedDescription]);
	}

}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port;
{
	QSTNetSocket *client = (QSTNetSocket*)sock.userData;
	[self processNewClient:client];
	[clients addObject:client];
	[client release]; // Match the alloc in didAccept...
}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
	QSTNetSocket *client = (QSTNetSocket*)sock.userData;

	// TODO: Tell delegate we lost this client?

	if([clients containsObject:client])
		[clients removeObject:client];
	else // An error before we processed the new client.
		[client release]; // Match the alloc in didAccept...
}



@end