//
//  QSTLog.m
//  Quest
//
//  Created by Per Borgman on 2010-03-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QSTLog.h"

@implementation QSTLog
@synthesize logLevel;

+(QSTLog*)log {
	static QSTLog* instance = nil;
	if(!instance)
		instance = [[QSTLog alloc] init];
	return instance;
}

-(id)init {
	if(![super init]) return nil;
	loggers = [[NSMutableDictionary alloc] init];
	logLevel = QSTLogLevelDebug;
	
	QSTLogger *engineLog = [[QSTLogger alloc] initWithName:@"Engine" log:self];
	[loggers setObject:engineLog forKey:@"Engine"];
	[engineLog release];
		
	return self;
}

-(void)logWithLoggers:(NSString*)loggerNames level:(QSTLogLevel)level message:(NSString*)msg, ... {
	va_list args;
	va_start(args, msg);
	NSString *str = [[NSString alloc] initWithFormat:msg arguments:args];
	va_end(args);
	
	NSArray *names = [loggerNames componentsSeparatedByString:@","];
	for(NSString* name in names) {
		QSTLogger *logger = [loggers objectForKey:name];
		if(logger) [logger log:str withLevel:level];
	}
	
	[str release];
}

-(QSTLogger*)loggerWithName:(NSString*)aName {
	return [loggers objectForKey:aName];
}

-(void)setLogLevel:(QSTLogLevel)level {
	logLevel = level;
	if(logLevel == QSTLogLevelUseMaster) logLevel = QSTLogLevelInfo;
}

@end

@interface QSTLogger()
@end

@implementation QSTLogger
@synthesize logLevel;

-(id)initWithName:(NSString*)name_ log:(QSTLog*)log_ {
	if(![super init]) return nil;
	master = log_;
	logLevel = QSTLogLevelUseMaster;
	name = [name_ retain];
	//filepath = [NSURL URLWithString:@"logs/"
	return self;
}

-(QSTLogLevel)level {
	if(logLevel == QSTLogLevelUseMaster) return master.logLevel;
	return logLevel;
}

-(void)log:(NSString*)str withLevel:(QSTLogLevel)level {
	if([self level] > level) return;
	if(level == QSTLogLevelDebug) [self debug:str];
	else if(level == QSTLogLevelInfo) [self info:str];
	else if(level == QSTLogLevelWarning) [self warning:str];
	else if(level == QSTLogLevelError) [self error:str];
	else [self fatal:str];
}

-(void)debug:(NSString*)str {
	
	printf("%s:   %s\n", [name UTF8String], [str UTF8String]);
}
	   
-(void)info:(NSString*)str {
	printf("%s: %s\n", [name UTF8String], [str UTF8String]);
}

-(void)warning:(NSString*)str {
	printf("%s: Warning: %s\n", [name UTF8String], [str UTF8String]);
}

-(void)error:(NSString*)str {
	printf("%s: ERROR: %s\n", [name UTF8String], [str UTF8String]);
}

-(void)fatal:(NSString*)str {
	printf("%s: FATAL: %s\n", [name UTF8String], [str UTF8String]);
}

@end