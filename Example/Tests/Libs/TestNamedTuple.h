//
//  TestNamedTuple.h
//  ZTuple_iOS_Tests
//
//  Created by William Zang on 2018/5/15.
//  Copyright (c) 2017 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

@import EasyTuple;

#define TestNamedTupleTable(_) \
_(NSString *, string) \
_(NSNumber *, number) \
_(NSDictionary *, dictionary)

EZTNamedTupleDef(TestNamedTuple)

#define TestNamedTupleWithGenericTable(_) \
_(NSArray<T> *, arr) \
_(NSDictionary<K, V> *, dic);

EZTNamedTupleDef(TestNamedTupleWithGeneric, T, K, V)

#define TestBlockNamedTupleTable(_) \
_(dispatch_block_t, block);

EZTNamedTupleDef(TestBlockNamedTuple)

#define TestProtocolNamedTupleTable(_) \
_(id<NSCopying>, key);

EZTNamedTupleDef(TestProtocolNamedTuple)
