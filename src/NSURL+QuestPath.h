//
//  NSURL+QuestPath.h
//  Quest
//
//  Created by Joachim Bengtsson on 2010-03-20.

#import <Foundation/Foundation.h>


@interface NSURL (QuestPath)
-(NSURL*)URLByAppendingPathComponents:(NSArray*)components;
@end

#define $joinUrls(base, ...) [base URLByAppendingPathComponents:$array(__VA_ARGS__)]