//
//  EZTupleSubClass.m
//
//  Created by Chengwei Zang on 2017/8/22.
//  Copyright (c) 2017 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

#import "EZTupleSubClasses.h"
@import ObjectiveC.runtime;

static NSString *propertyNameForIndex(EZTupleBase *tuple, NSUInteger index) {
    Class tupleClass = tuple.class;
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(tupleClass, &outCount);
    const char *propertyCName = NULL;
    if (index < outCount) {
        objc_property_t property = properties[index];
        propertyCName = property_getName(property);
    }
    free(properties);
    NSString *propertyName = [NSString stringWithCString:propertyCName encoding:NSASCIIStringEncoding];
    return propertyName;
}

#define _EZT_INIT_PARAM_IMP_FIRST(index)                EZ_ORDINAL_CAP_AT(index):(id)EZ_ORDINAL_AT(index)
#define _EZT_INIT_PARAM_IMP(index)                      EZ_ORDINAL_AT(index):(id)EZ_ORDINAL_AT(index)
#define EZT_INIT_PARAM_IMP(index)                       EZ_IF_EQ(0, index)(_EZT_INIT_PARAM_IMP_FIRST(index))(_EZT_INIT_PARAM_IMP(index))

#define EZT_SYNTHESIZE(index) \
@synthesize EZ_ORDINAL_AT(index) = EZ_CONCAT(_, EZ_ORDINAL_AT(index))

#define EZT_INIT_SET_PARAM(index) \
EZ_CONCAT(_, EZ_ORDINAL_AT(index)) = EZ_ORDINAL_AT(index); \
self.hashValue ^= (NSUInteger)EZ_ORDINAL_AT(index)

#define EZT_SETTER(index) \
EZT_PrivateSetterDef(index) { \
    NSString *propertyName = propertyNameForIndex(self, index); \
    if (![propertyName isEqual:@EZ_STRINGIFY(EZ_ORDINAL_AT(index))]) { \
        [self willChangeValueForKey:propertyName]; \
    } \
    if (![@EZ_STRINGIFY(EZ_ORDINAL_AT(index)) isEqual:key]) { \
        [self willChangeValueForKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(index))]; \
    } \
    self.hashValue ^= (NSUInteger)EZ_CONCAT(_, EZ_ORDINAL_AT(index)); \
    EZ_CONCAT(_, EZ_ORDINAL_AT(index)) = value; \
    self.hashValue ^= (NSUInteger)value; \
    if (![@EZ_STRINGIFY(EZ_ORDINAL_AT(index)) isEqual:key]) { \
        [self didChangeValueForKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(index))]; \
    } \
    if (![propertyName isEqual:@EZ_STRINGIFY(EZ_ORDINAL_AT(index))]) { \
        [self didChangeValueForKey:propertyName];\
    }\
} \
- (void)EZ_CONCAT(set, EZ_ORDINAL_CAP_AT(index)):(id)value { \
    [self EZ_CONCAT(_set, EZ_ORDINAL_CAP_AT(index)):value excludeNotifiyKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(index))]; \
}

#define EZT_APPEND_DESCRIPTION(index) \
[description appendString:@"\t" EZ_STRINGIFY(EZ_ORDINAL_AT(index)) " = "]; \
[description appendString:[self. EZ_ORDINAL_AT(index) description] ?: @"nil"]; \
[description appendString:@";\n"];

#define EZ_TUPLE_IMP(i) \
@implementation EZ_CONCAT(EZTuple, i) \
EZ_FOR_RECURSIVE(i, EZT_SYNTHESIZE, ;); \
\
- (instancetype)EZ_CONCAT(initWith, EZ_FOR_SPACE(i, EZT_INIT_PARAM_IMP)) { \
    if (self = [super init]) { \
        EZ_FOR_RECURSIVE(i, EZT_INIT_SET_PARAM, ;); \
    } \
    return self; \
} \
\
- (NSUInteger)count { \
    return i; \
} \
\
EZ_FOR_RECURSIVE(EZ_DEC(i), EZT_SETTER, ;) \
\
EZT_PrivateSetterDef(EZ_DEC(i)) { \
    NSString *propertyName = propertyNameForIndex(self, EZ_DEC(i)); \
    if (![propertyName isEqual:@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i)))]) { \
        [self willChangeValueForKey:propertyName]; \
    } \
    if (![@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i))) isEqual:key]) { \
        [self willChangeValueForKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i)))]; \
    } \
    if (![@"last" isEqual:key]) { \
        [self willChangeValueForKey:@"last"]; \
    } \
    self.hashValue ^= (NSUInteger)EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i))); \
    EZ_CONCAT(_, EZ_ORDINAL_AT(EZ_DEC(i))) = value; \
    self.hashValue ^= (NSUInteger)value; \
    if (![@"last" isEqual:key]) { \
        [self didChangeValueForKey:@"last"]; \
    } \
    if (![@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i))) isEqual:key]) { \
        [self didChangeValueForKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i)))]; \
    } \
    if (![propertyName isEqual:@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i)))]) { \
        [self didChangeValueForKey:propertyName];\
    }\
} \
- (void)EZ_CONCAT(set, EZ_ORDINAL_CAP_AT(EZ_DEC(i))):(id)value { \
    [self EZ_CONCAT(_set, EZ_ORDINAL_CAP_AT(EZ_DEC(i))):value excludeNotifiyKey:@EZ_STRINGIFY(EZ_ORDINAL_AT(EZ_DEC(i)))]; \
} \
\
- (id)last { \
return self. EZ_ORDINAL_AT(EZ_DEC(i)); \
} \
\
- (void)setLast:(id)last { \
  [self EZ_CONCAT(_set, EZ_ORDINAL_CAP_AT(EZ_DEC(i))):last excludeNotifiyKey:@"last"]; \
} \
\
- (NSString *)description { \
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: %p>(\n", self.class, self]; \
    EZ_FOR_RECURSIVE(i, EZT_APPEND_DESCRIPTION, ;) \
    [description appendString:@"\tlast = "]; \
    [description appendString:[self. EZ_ORDINAL_AT(EZ_DEC(i)) description] ?: @"nil"]; \
    [description appendString:@";\n)"]; \
    return description; \
} \
@end

#define EZ_TUPLE_IMP_FOREACH(index)           EZ_TUPLE_IMP(EZ_INC(index))

EZ_FOR(20, EZ_TUPLE_IMP_FOREACH, ;)
