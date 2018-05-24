//
//  TestNamedTuple.h
//  ZTuple_iOS_Tests
//
//  Created by William Zang on 2018/5/15.
//  Copyright © 2018年 WilliamZang. All rights reserved.
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
