//
//  QSTNetworkSystem.h
//  Quest
//
//  Created by Joachim Bengtsson on 2010-03-20.

#import <Foundation/Foundation.h>
#import "QSTNetSocket.h"

@class QSTCore;


@interface QSTNetworkSystem : NSObject {
	QSTCore *core;
}
-(id)initOnCore:(QSTCore*)core;
@end

@interface QSTClientNetworkSystem : QSTNetworkSystem <QSTNetSocketDelegate>{
	QSTNetSocket *socket;
	NSString *host;
}
// Setting the host will connect; unsetting it will disconnect.
@property (nonatomic,copy) NSString *host;
@end

@interface QSTServerNetworkSystem : QSTNetworkSystem <QSTNetSocketDelegate>{
	AsyncSocket *listen;
	NSMutableArray *clients;
}

@end