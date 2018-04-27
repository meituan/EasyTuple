    //
    //  ZTupleSubClass.m
    //  Expecta-iOS
    //
    //  Created by Chengwei Zang on 2017/8/22.
    //

#import "EZTupleSubClasses.h"

#define _EZT_INIT_PARAM_IMP_FIRST(index)                          EZ_ORDINAL_CAP_AT(index):(id)EZ_ORDINAL_AT(index)
#define _EZT_INIT_PARAM_IMP(index)                                EZ_ORDINAL_AT(index):(id)EZ_ORDINAL_AT(index)
#define EZT_INIT_PARAM_IMP(index)                                 EZ_IF_EQ(0, index)(_EZT_INIT_PARAM_IMP_FIRST(index))(_EZT_INIT_PARAM_IMP(index))

#define EZT_SYNTHESIZE(index)                                                                                                    \
@synthesize EZ_ORDINAL_AT(index) = EZ_CONCAT(_, EZ_ORDINAL_AT(index))

#define EZT_INIT_SET_PARAM(index)                                                                                                \
EZ_CONCAT(_, EZ_ORDINAL_AT(index)) = EZ_ORDINAL_AT(index);                                                                        \
self.hashValue ^= (NSUInteger)EZ_ORDINAL_AT(index)

#define EZT_COPY_SET(index)                                    copied. EZ_ORDINAL_AT(index) = self. EZ_ORDINAL_AT(index)

#define EZT_SETTER(index)                                                                                                        \
- (void)EZ_CONCAT(set, EZ_ORDINAL_CAP_AT(index)):(id)value {                                                                     \
self.hashValue ^= (NSUInteger)EZ_CONCAT(_, EZ_ORDINAL_AT(index));                                                                \
EZ_CONCAT(_, EZ_ORDINAL_AT(index)) = value;                                                                                      \
self.hashValue ^= (NSUInteger)value;                                                                                           \
}

#define EZ_TUPLE_IMP(i)                                                                                                         \
@implementation EZ_CONCAT(EZTuple, i)                                                                                            \
EZ_FOR_RECURSIVE(i, EZT_SYNTHESIZE, ;);                                                                                           \
                                                                                                                               \
- (instancetype)EZ_CONCAT(initWith, EZ_FOR_SPACE(i, EZT_INIT_PARAM_IMP)) {                                                         \
if (self = [super init]) {                                                                                                     \
EZ_FOR_RECURSIVE(i, EZT_INIT_SET_PARAM, ;);                                                                                       \
}                                                                                                                              \
return self;                                                                                                                   \
}                                                                                                                              \
                                                                                                                               \
- (nonnull id)copyWithZone:(nullable NSZone *)zone {                                                                           \
EZ_CONCAT(EZTuple, i) *copied = [EZ_CONCAT(EZTuple, i) new];                                                                       \
EZ_FOR_RECURSIVE(i, EZT_COPY_SET, ;);                                                                                             \
copied.hashValue = self.hashValue;                                                                                             \
return copied;                                                                                                                 \
}                                                                                                                              \
                                                                                                                               \
EZ_FOR_RECURSIVE(EZ_DEC(i), EZT_SETTER, ;)                                                                                         \
                                                                                                                               \
- (id)EZ_ORDINAL_AT(EZ_DEC(i)) {                                                                                                 \
return EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i)));                                                                                    \
}                                                                                                                              \
                                                                                                                               \
- (void)EZ_CONCAT(set, EZ_ORDINAL_CAP_AT(EZ_DEC(i))):(id)value {                                                                  \
self.hashValue ^= (NSUInteger)EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i)));                                                             \
[self willChangeValueForKey:@"last"];                                                                                          \
EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i))) = value;                                                                                   \
self.hashValue ^= (NSUInteger)value;                                                                                           \
[self didChangeValueForKey:@"last"];                                                                                           \
}                                                                                                                              \
                                                                                                                               \
- (id)last {                                                                                                                   \
return EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i)));                                                                                    \
}                                                                                                                              \
                                                                                                                               \
- (void)setLast:(id)last {                                                                                                     \
self.hashValue ^= (NSUInteger)EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i)));                                                             \
[self willChangeValueForKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i)))];                                                             \
EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i))) = last;                                                                                    \
self.hashValue ^= (NSUInteger)last;                                                                                            \
[self didChangeValueForKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i)))];                                                              \
}                                                                                                                              \
                                                                                                                               \
@end

#define EZ_TUPLE_IMP_FOREACH(index)           EZ_TUPLE_IMP(EZ_INC(index))

EZ_FOR(20, EZ_TUPLE_IMP_FOREACH, ;)
