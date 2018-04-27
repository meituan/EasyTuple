//
//  EZTupleBase.h
//  Expecta
//
//  Created by Chengwei Zang on 2017/8/3.
//

#import <Foundation/Foundation.h>

@interface EZTupleBase : NSObject <NSCopying, NSFastEnumeration>

@property (nonatomic, assign) NSUInteger hashValue;
@property (nonatomic, assign, readonly) NSUInteger count;

+ (instancetype)tupleWithArray:(NSArray *)array;
+ (__kindof EZTupleBase *)tupleWithCount:(NSUInteger)count;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
- (__kindof EZTupleBase *)join:(EZTupleBase *)other;
- (__kindof EZTupleBase *)take:(NSUInteger)count;
- (__kindof EZTupleBase *)drop:(NSUInteger)count;
- (NSArray *)allObjects;

@end
