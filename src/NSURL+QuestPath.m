//
//  NSURL+QuestPath.m
//  Quest
//
//  Created by Joachim Bengtsson on 2010-03-20.

#import "NSURL+QuestPath.h"


@implementation NSURL (QuestPath)
-(NSURL*)URLByAppendingPathComponents:(NSArray*)components;
{
	NSURL *ack = self;
	for (NSString *component in components) {
		ack = [ack URLByAppendingPathComponent:component];
	}
	return ack;
}
@end
