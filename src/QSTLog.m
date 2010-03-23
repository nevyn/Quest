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
	
	[engineLog debug:@"-------- Initialized Log System --------"];
	
	return self;
}

-(QSTLogger*)loggerWithName:(NSString*)aName {
	return [loggers objectForKey:aName];
}

-(void)setLogLevel:(QSTLogLevel)level {
	logLevel = level;
	if(logLevel == QSTLogLevelUseMaster) logLevel = QSTLogLevelInfo;
}

@end

#define DO_OUTPUT(lvl) if([self level]>lvl)return; va_list args;va_start(args, str);[self log:[[NSString alloc] initWithFormat:str arguments:args]];va_end(args)

@interface QSTLogger()
-(void)log:(NSString*)str;
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

-(void)debug:(NSString*)str, ... {
	DO_OUTPUT(QSTLogLevelDebug);
}
	   
-(void)info:(NSString*)str, ... {
	DO_OUTPUT(QSTLogLevelInfo);
}

-(void)warning:(NSString*)str, ... {
	DO_OUTPUT(QSTLogLevelWarning);
}

-(void)error:(NSString*)str, ... {
	DO_OUTPUT(QSTLogLevelError);
}

-(void)fatal:(NSString*)str, ... {
	DO_OUTPUT(QSTLogLevelError);
}

-(void)log:(NSString*)str {
	printf("%s: %s\n", [name UTF8String], [str UTF8String]);
}

@end

			/*
@implementation QSTConsoleLogger 

-(void)log:(NSString*)str, ... {
	printf("%s\n", [str UTF8String]);
}

@end*/
