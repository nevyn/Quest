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

#define Debug(loggers, str, ...) [[QSTLog log] logWithLoggers:loggers level:QSTLogLevelDebug message:str, ##__VA_ARGS__]
#define Info(loggers, str, ...)	[[QSTLog log] logWithLoggers:loggers level:QSTLogLevelInfo message:str, ##__VA_ARGS__]
#define Warning(loggers, str, ...) [[QSTLog log] logWithLoggers:loggers level:QSTLogLevelWarning message:str, ##__VA_ARGS__]
#define Error(loggers, str, ...) [[QSTLog log] logWithLoggers:loggers level:QSTLogLevelError message:str, ##__VA_ARGS__]
#define Fatal(loggers, str, ...) [[QSTLog log] logWithLoggers:loggers level:QSTLogLevelFatal message:str, ##__VA_ARGS__]

@class QSTLogger;

// Singleton class for logging

@interface QSTLog : NSObject {
	QSTLogLevel logLevel;
	NSMutableDictionary *loggers;
}

+(QSTLog*)log;
-(id)init;

-(void)logWithLoggers:(NSString*)loggerNames level:(QSTLogLevel)level message:(NSString*)msg, ...;

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

-(id)initWithName:(NSString*)name_ log:(QSTLog*)log_;

-(void)log:(NSString*)str withLevel:(QSTLogLevel)level;

-(void)debug:(NSString*)str;
-(void)info:(NSString*)str;
-(void)warning:(NSString*)str;
-(void)error:(NSString*)str;
-(void)fatal:(NSString*)str;
@end
/*
@interface QSTConsoleLogger : QSTLogger {
}
-(void)log:(NSString*)str, ...;
@end
*/