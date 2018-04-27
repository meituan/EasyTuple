//
//  ZTupleTests.m
//  ZTupleTests
//
//  Created by WilliamZang on 08/03/2017.
//  Copyright (c) 2017 WilliamZang. All rights reserved.
//

// https://github.com/Specta/Specta

void enumerationMutationHandler(id object) {
    [[NSThread currentThread] threadDictionary][@"mutationErrorObject"] = object;
}

SpecBegin(ZTupleTests)

describe(@"tuple tests", ^{
    context(@"ordinal property", ^{
        it(@"can access tuple using properties", ^{
            EZTuple3<NSNumber *, NSString *, NSDictionary *> *tuple = [[EZTuple3 alloc] initWithFirst:@3 second:@"string" third:@{@"key": @"value"}];
            
            expect(tuple.first).to.equal(@3);
            expect(tuple.second).to.equal(@"string");
            expect(tuple.third).to.equal(@{@"key": @"value"});
            expect(tuple.last).to.equal(tuple.third);
            
            tuple.first = @5;
            expect(tuple.first).to.equal(@5);
            
            tuple.last = @{@"key": @"value2"};
            expect(tuple.third).to.equal(@{@"key": @"value2"});
        });
        
        it(@"can create a new tuple using macro", ^{
            EZTuple4<NSNumber *, NSNumber *, NSNumber *, NSNumber *> *tuple = EZTuple(@1, @2, @3, @4);
            
            expect(tuple.first).to.equal(@1);
            expect(tuple.second).to.equal(@2);
            expect(tuple.third).to.equal(@3);
            expect(tuple.fourth).to.equal(@4);
            expect(tuple.last).to.equal(@4);
        });
        
        it(@"can unpack tuple using macro", ^{
            EZTuple4<NSNumber *, NSNumber *, NSNumber *, NSNumber *> *tuple = EZTuple(@1, @2, @3, @4);
            
            EZTupleUnpack(NSNumber *a, NSNumber *b, NSNumber *c, NSNumber *d, EZT_FromVar(tuple));

            expect(a).to.equal(@1);
            expect(b).to.equal(@2);
            expect(c).to.equal(@3);
            expect(d).to.equal(@4);
        });
        
        it(@"can invoke KVO", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            
            id observer = [OCMockObject mockForClass:NSObject.class];
            
            [[observer expect] observeValueForKeyPath:@"second"
                                             ofObject:tuple
                                               change:@{NSKeyValueChangeNewKey: @5,
                                                        NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                        }
                                              context:OCMArg.anyPointer];
            
            [tuple addObserver:observer
                    forKeyPath:@"second"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
            
            tuple.second = @5;
            
            [observer verify];
            
            [tuple removeObserver:observer forKeyPath:@"second"];
        });
        
        it(@"can observe property named last, will invoke observe callback when set the last ordinal oproperty", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            
            id observer1 = [OCMockObject mockForClass:NSObject.class];
            id observer2 = [OCMockObject mockForClass:NSObject.class];
            
            [[observer1 expect] observeValueForKeyPath:@"last"
                                              ofObject:tuple
                                                change:@{NSKeyValueChangeNewKey: @5,
                                                         NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                         }
                                               context:OCMArg.anyPointer];
            [[observer2 expect] observeValueForKeyPath:@"third"
                                              ofObject:tuple
                                                change:@{NSKeyValueChangeNewKey: @5,
                                                         NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                         }
                                               context:OCMArg.anyPointer];
            
            [tuple addObserver:observer1
                    forKeyPath:@"last"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
            
            [tuple addObserver:observer2
                    forKeyPath:@"third"
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
            
            tuple.third = @5;
            
            [observer1 verify];
            [observer2 verify];
            
            [[observer1 expect] observeValueForKeyPath:@"last"
                                              ofObject:tuple
                                                change:@{NSKeyValueChangeNewKey: @7,
                                                         NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                         }
                                               context:OCMArg.anyPointer];
            [[observer2 expect] observeValueForKeyPath:@"third"
                                              ofObject:tuple
                                                change:@{NSKeyValueChangeNewKey: @7,
                                                         NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                         }
                                               context:OCMArg.anyPointer];
            
            tuple.last = @7;
            
            [observer1 verify];
            [observer2 verify];
            
            [tuple removeObserver:observer1 forKeyPath:@"last"];
            [tuple removeObserver:observer2 forKeyPath:@"third"];
        });
    });

    context(@"subscript", ^{
        it(@"can access subscript", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            
            expect(tuple[0]).to.equal(@1);
            expect(tuple[1]).to.equal(@2);
            expect(tuple[2]).to.equal(@3);
            
            tuple[0] = @4;
            
            expect(tuple.first).to.equal(@4);
        });
        
        it(@"will raise an assert if access over subscript", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            id assertHandler = [OCMockObject mockForClass:NSAssertionHandler.class];
            
            [[[assertHandler expect] ignoringNonObjectArgs] handleFailureInMethod:@selector(objectForKeyedSubscript:) object:tuple file:OCMOCK_ANY lineNumber:0 description:@"Invalid parameter not satisfying: %@", @"%@"];
            
            [[[NSThread currentThread] threadDictionary] setValue:assertHandler
                                                           forKey:NSAssertionHandlerKey];
            
            id any __attribute((unused)) = tuple[3];
            
            [assertHandler verify];
            
            [[[assertHandler expect] ignoringNonObjectArgs] handleFailureInMethod:@selector(setObject:atIndexedSubscript:) object:tuple file:OCMOCK_ANY lineNumber:0 description:@"Invalid parameter not satisfying: %@", @"%@"];
            
            tuple[4] = @5;
            
            [assertHandler verify];
            
            [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];
        });
    });
    
    context(@"fast enumeration", ^{
        it(@"can use for in to access tuple", ^{
            EZTuple20 *tuple = EZTuple(@1, @2, @3, @4, @5, @6, @7, @8, @9, @10,
                                     @11, @12, @13, @14, @15, @16, @17, @18, @19, @20);
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSNumber *number in tuple) {
                [array addObject:number];
            }
            expect(array).to.equal(@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10,
                                     @11, @12, @13, @14, @15, @16, @17, @18, @19, @20]);
        });
        
        it(@"can use for(;;) to access tuple", ^{
            EZTuple20 *tuple = EZTuple(@1, @2, @3, @4, @5, @6, @7, @8, @9, @10,
                                     @11, @12, @13, @14, @15, @16, @17, @18, @19, @20);
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (int i = 0; i < tuple.count; i++) {
                [array addObject:tuple[i]];
            }
            
            expect(array).to.equal(@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10,
                                     @11, @12, @13, @14, @15, @16, @17, @18, @19, @20]);
        });
        
        it(@"can access nil item use for-in", ^{
            EZTuple4 *tuple = EZTuple(@1, @2, @3, nil);
            
            NSMutableArray *array = [NSMutableArray array];
            BOOL hasNil = NO;
            for (NSNumber *number in tuple) {
                if (number == nil) {
                    hasNil = YES;
                } else {
                    [array addObject:number];
                }
            }
            expect(hasNil).to.beTruthy();
            expect(array).to.equal(@[@1, @2, @3]);
        });
        
        it(@"will raise error if modify any item when enumeration", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            
            objc_setEnumerationMutationHandler(enumerationMutationHandler);
            
            for(NSNumber *number in tuple) {
                id useless __attribute((unused)) = number;
                tuple[1] = @5;
            }
            
            expect([[NSThread currentThread] threadDictionary][@"mutationErrorObject"]).to.equal(tuple);
            [[NSThread currentThread] threadDictionary][@"mutationErrorObject"] = nil;
            
            for(NSNumber *number in tuple) {
                id useless __attribute((unused)) = number;
                tuple.last = @12;
            }
            expect([[NSThread currentThread] threadDictionary][@"mutationErrorObject"]).to.equal(tuple);
            [[NSThread currentThread] threadDictionary][@"mutationErrorObject"] = nil;
            
            objc_setEnumerationMutationHandler(NULL);
        });
    });
    
    context(@"copy", ^{
        it(@"can copy to get a cloned one", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            EZTuple3 *tupleCopied = [tuple copy];
            
            expect(tupleCopied.first).to.equal(@1);
            expect(tupleCopied.second).to.equal(@2);
            expect(tupleCopied.third).to.equal(@3);
        });
    });
    
    context(@"join", ^{
        it(@"can join two tuples use method join:", ^{
            EZTuple2 *tuple1 = EZTuple(@1, @2);
            EZTuple3 *tuple2 = EZTuple(@3, @4, @5);
            
            expect([tuple1 join:tuple2]).to.equal(EZTuple(@1, @2, @3, @4, @5));
        });
        
        it(@"should raise an assert if two tuples itme count larger than 20", ^{
            EZTuple11 *tuple1 = EZTuple(@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11);
            EZTuple11 *tuple2 = EZTuple(@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11);
            id assertHandler = [OCMockObject mockForClass:NSAssertionHandler.class];
            
            [[[assertHandler expect] ignoringNonObjectArgs] handleFailureInMethod:@selector(join:) object:tuple1 file:OCMOCK_ANY lineNumber:0 description:@"two tuple items count added cannot larger than 20"];
            
            [[[NSThread currentThread] threadDictionary] setValue:assertHandler
                                                           forKey:NSAssertionHandlerKey];
            
            EZTupleBase *tuple3 = [tuple1 join:tuple2];
            expect(tuple3).to.beNil();
            [assertHandler verify];
            
            [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];
        });
        
        it(@"can use extend macro add some new item to exist tuple", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            EZTuple5 *tuple5 = EZTupleExtend(tuple, @4, @5);
            
            expect(tuple5).to.equal(EZTuple(@1, @2, @3, @4, @5));
        });
    });
    
    context(@"take & drop", ^{
        it(@"can take first N item from tuple", ^{
            EZTuple4 *tuple = EZTuple(@1, @2, @3, @4);
            EZTuple2 *tuple2 = [tuple take:2];
            
            expect(tuple2).to.equal(EZTuple(@1, @2));
        });
        
        it(@"should get a clone if taken N is larger than tuple's count", ^{
            EZTuple4 *tuple = EZTuple(@1, @2, @3, @4);
            EZTuple4 *tuple2 = [tuple take:15];
            
            expect(tuple2).to.equal(tuple);
        });
        
        it(@"should raise an assert if N is 0", ^{
            EZTuple11 *tuple = EZTuple(@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11);
            id assertHandler = [OCMockObject mockForClass:NSAssertionHandler.class];
            
            [[[assertHandler expect] ignoringNonObjectArgs] handleFailureInMethod:@selector(join:) object:tuple file:OCMOCK_ANY lineNumber:0 description:@"Invalid parameter not satisfying: %@", @"count >= 1 && count <= tupleCountWithObject(self)"];
            
            [[[NSThread currentThread] threadDictionary] setValue:assertHandler
                                                           forKey:NSAssertionHandlerKey];
            
            EZTupleBase *tuple2 = [tuple take:0];
            expect(tuple2).to.beNil();
            [assertHandler verify];
            
            [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];
        });
        
        it(@"can drop first N itme from tuple", ^{
            EZTuple4 *tuple = EZTuple(@1, @2, @3, @4);
            EZTuple2 *tuple2 = [tuple drop:2];
            
            expect(tuple2).to.equal(EZTuple(@3, @4));
        });
        
        it(@"should raise an assert if N is larger or equal than tuple's count", ^{
            EZTuple11 *tuple = EZTuple(@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11);
            id assertHandler = [OCMockObject mockForClass:NSAssertionHandler.class];
            
            [[[assertHandler expect] ignoringNonObjectArgs] handleFailureInMethod:@selector(join:) object:tuple file:OCMOCK_ANY lineNumber:0 description:@"Invalid parameter not satisfying: %@", @"count < selfCount"];
            
            [[[NSThread currentThread] threadDictionary] setValue:assertHandler
                                                           forKey:NSAssertionHandlerKey];
            
            EZTupleBase *tuple2 = [tuple drop:11];
            expect(tuple2).to.beNil();
            [assertHandler verify];
            
            [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];
        });
        
        it(@"should get a clone if drop N is zero", ^{
            EZTuple4 *tuple = EZTuple(@1, @2, @3, @4);
            EZTuple4 *tuple2 = [tuple drop:0];
            
            expect(tuple2).to.equal(tuple);
        });
    });
    
    context(@"tuple and array convert", ^{
        it(@"can convert a tuple to an array", ^{
            EZTuple3 *tuple = EZTuple(@1, @2, @3);
            
            expect([tuple allObjects]).to.equal(@[@1, @2, @3]);
        });
        
        it(@"should use NSNull instead nil when convert to an array", ^{
            EZTuple3 *tuple = EZTuple(@1, nil, @3);
            
            expect([tuple allObjects]).to.equal(@[@1, NSNull.null, @3]);
        });
        
        it(@"can convert an array to a tuple", ^{
            EZTupleBase *tuple = [EZTupleBase tupleWithArray:@[@1, @2, @3]];
            
            expect(tuple).to.equal(EZTuple(@1, @2, @3));
        });
        
        it(@"should use nil instead NSNull when convert to a tuple", ^{
            EZTupleBase *tuple = [EZTupleBase tupleWithArray:@[@1, NSNull.null, @3]];
            
            expect(tuple).to.equal(EZTuple(@1, nil, @3));
        });
    });
    
    context(@"others", ^{
        it(@"will show description like NSArray", ^{
            EZTuple2 *tuple = EZTuple(@1, @2);
            
            expect(tuple.description).to.equal([NSString stringWithFormat:@"<EZTuple2: 0x%lx>(\n    1,\n    2\n)", (unsigned long)tuple]);
        });
        
        it(@"will show nil as null", ^{
            EZTuple3 *tuple = EZTuple(@1, nil, @3);
            
            expect(tuple.description).to.equal([NSString stringWithFormat:@"<EZTuple3: 0x%lx>(\n    1,\n    \"<null>\",\n    3\n)", (unsigned long)tuple]);
        });
        
        it(@"will create a new tuple with count arg", ^{
            EZTuple3 *tuple = [EZTupleBase tupleWithCount:3];
            
            expect(tuple).to.beKindOf([EZTuple3 class]);
        });
    });
});

SpecEnd

