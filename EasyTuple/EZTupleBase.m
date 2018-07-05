//
//  EZTupleBase.m
//
//  Created by Chengwei Zang on 2017/8/3.
//  Copyright (c) 2017 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

#import "EZTupleBase.h"
#import "EZTupleSubClasses.h"
#import "EZMetaMacros.h"
#include "string.h"
@import ObjectiveC.runtime;

#define EZT_SETTER_FUNC_DEF(index)                                                                                               \
static void EZ_CONCAT(setter, index)(EZ_CONCAT(EZTuple, EZ_INC(index)) *tuple, id value) {                                         \
    tuple. EZ_ORDINAL_AT(index) = value;                                                                                        \
}

EZ_FOR_SPACE(20, EZT_SETTER_FUNC_DEF)

#define EZT_GETTER_FUNC_DEF(index)                                                                                               \
static id EZ_CONCAT(getter, index)(EZ_CONCAT(EZTuple, EZ_INC(index)) *tuple) {                                                     \
    return [tuple EZ_ORDINAL_AT(index)];                                                                                        \
}

EZ_FOR_SPACE(20, EZT_GETTER_FUNC_DEF)

typedef void (*SetterType)(EZTupleBase *tuple, id value);

#define EZT_SETTER_TABLE_ITEM(index)     & EZ_CONCAT(setter, index)

SetterType setterTable[] = {
    EZ_FOR_COMMA(20, EZT_SETTER_TABLE_ITEM)
};

typedef id (*GetterType)(EZTupleBase *tuple);

#define EZT_GETTER_TABLE_ITEM(index)     & EZ_CONCAT(getter, index)

GetterType getterTable[] = {
    EZ_FOR_COMMA(20, EZT_GETTER_TABLE_ITEM)
};

@implementation EZTupleBase

+ (instancetype)tupleWithArray:(NSArray *)array {
    EZTupleBase *tuple = [self tupleWithCount:array.count];
    for (int i = 0; i < array.count; ++i) {
        tuple[i] = [array[i] isEqual:NSNull.null] ? nil : array[i];
    }
    return tuple;
}

+ (__kindof EZTupleBase *)tupleWithCount:(NSUInteger)count {
#define TUPLE_CLASS(_COUNT_)    "EZTuple" EZ_STRINGIFY(_COUNT_)
#define CLASS_TABLE             EZ_FOR_COMMA(20, TUPLE_CLASS)
    static const char *classNames[] = {
        CLASS_TABLE
    };
#undef CLASS_TABLE
#undef TUPLE_CLASS
    NSAssert(count <= 20 && count != 0, @"There is only 20 tuple classes.");
    const char *className = classNames[count];
    Class tupleClass = objc_getClass(className);
    EZTupleBase *tuple = [tupleClass new];
    return tuple;
}

- (NSUInteger)hash {
    return self.hashValue;
}

- (NSUInteger)count {
    return 0;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    NSParameterAssert(idx < self.count);
    if (idx < self.count) {
        return getterTable[idx](self);
    } else {
        return nil;
    }
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    NSParameterAssert(idx < self.count);
    if (idx < self.count) {
        setterTable[idx](self, obj);
    }
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    EZTupleBase *copied = [[self class] new];
    for (int i = 0; i < self.count; ++i) {
        copied[i] = self[i];
    }
    return copied;
}

- (NSUInteger)countByEnumeratingWithState:(nonnull NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained * _Nonnull)buffer count:(NSUInteger)len {
    NSUInteger count = self.count;
    if (state->state == count) {
        return 0;
    }
    
    Ivar ivar = class_getInstanceVariable(self.class, "_first");
    
    state->itemsPtr = (id  _Nullable __unsafe_unretained * _Nonnull)((__bridge void *)self + ivar_getOffset(ivar));
    state->mutationsPtr = (typeof(state->mutationsPtr))&self->_hashValue;
    
    state->state = count;
    return count;
}

- (BOOL)isEqual:(EZTupleBase *)other {
    if (![other isKindOfClass:EZTupleBase.class]) {
        return NO;
    }
    if (self == other) {
        return YES;
    }
    if (self.count != other.count) {
        return NO;
    }
    for (int i = 0; i < self.count; ++i) {
        if (self[i] == other[i] || [self[i] isEqual:other[i]]) {
            continue;
        }
        return NO;
    }
    return YES;
}

- (__kindof EZTupleBase *)join:(EZTupleBase *)other {
    NSUInteger selfCount = self.count;
    NSUInteger otherTupleCount = other.count;
    NSAssert(selfCount + otherTupleCount <= 20, @"two tuple items count added cannot larger than 20");
    if (selfCount + otherTupleCount > 20) {
        return nil;
    }
    EZTupleBase *newInstance = [EZTupleBase tupleWithCount:selfCount + otherTupleCount];
    for (int i = 0; i < selfCount; ++i) {
        newInstance[i] = self[i];
    }
    for (int i = 0; i < otherTupleCount; ++i) {
        newInstance[selfCount + i] = other[i];
    }
    return newInstance;
}

- (__kindof EZTupleBase *)take:(NSUInteger)count {
    NSParameterAssert(count >= 1);
    if (count < 1) {
        return nil;
    }
    if (count >= self.count) {
        return [self copy];
    }
    EZTupleBase *newInstance = [EZTupleBase tupleWithCount:count];
    for (int i = 0; i < count; ++i) {
        newInstance[i] = self[i];
    }
    return newInstance;
}

- (__kindof EZTupleBase *)drop:(NSUInteger)count {
    NSUInteger selfCount = self.count;
    NSParameterAssert(count < selfCount);
    if (count >= selfCount) {
        return nil;
    }
    if (count == 0) {
        return [self copy];
    }
    EZTupleBase *newInstance = [EZTupleBase tupleWithCount:selfCount - count];
    for (int i = 0; i + count < selfCount; ++i) {
        newInstance[i] = self[i + count];
    }
    return newInstance;;
}

- (NSArray *)allObjects {
    NSMutableArray *array = [NSMutableArray array];
    for (NSObject *item in self) {
        [array addObject:item ?: NSNull.null];
    }
    return [array copy];
}

@end
