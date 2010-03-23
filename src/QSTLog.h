//
//  QSTLog.h
//  Quest
//
//  Created by Per Borgman on 2010-03-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
	QSTLogLevelDebug,
	QSTLogLevelInfo,
	QSTLogLevelWarning,
	QSTLogLevelError,
	QSTLogLevelFatal,
	QSTLogLevelUseMaster
} QSTLogLevel;

@class QSTLogger;

// Singleton class for logging

@interface QSTLog : NSObject {
	QSTLogLevel logLevel;
	NSMutableDictionary *loggers;
}

+(QSTLog*)log;
-(id)init;

-(QSTLogger*)loggerWithName:(NSString*)aName;

@property (nonatomic) QSTLogLevel logLevel;

@end

@interface QSTLogger : NSObject {
	QSTLog		*master;
	QSTLogLevel logLevel;
	NSString	*name;
	NSURL		*filepath;
}
@property (nonatomic) QSTLogLevel logLevel;

-(void)debug:(NSString*)str, ...;
-(void)info:(NSString*)str, ...;
-(void)warning:(NSString*)str, ...;
-(void)error:(NSString*)str, ...;
-(void)fatal:(NSString*)str, ...;
@end
/*
@interface QSTConsoleLogger : QSTLogger {
}
-(void)log:(NSString*)str, ...;
@end
*/