//
//  GraphicsSystem.h
//  Quest
//
//  Created by Per Borgman on 20/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class QSTSceneLayered2D;


@protocol QSTScene
@end

/*@interface QSTBatch {
	QSTBatchSettings	settings;
	NSArray				*components;
}
@end*/


@interface QSTGraphicsSystem : NSObject {
	// Egentligen id eller id<QSTScene>
	QSTSceneLayered2D	*scene;
}

-(id)init;
-(void)tick;

@property (nonatomic,readonly) QSTSceneLayered2D *scene;

@end
