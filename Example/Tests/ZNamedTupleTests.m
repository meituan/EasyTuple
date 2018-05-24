//
//  EZNamedTuple.m
//  ZTuple_iOS_Tests
//
//  Created by William Zang on 2018/5/17.
//  Copyright © 2018年 WilliamZang. All rights reserved.
//

@import ObjectiveC.runtime;
@import Specta;
@import Expecta;
@import OCHamcrest;
@import OCMockito;
@import EasyTuple;
#import "TestNamedTuple.h"

static void enumerationMutationHandler(id object) {
    [[NSThread currentThread] threadDictionary][@"mutationErrorObject"] = object;
}

SpecBegin(ZNamedTupleTests)

describe(@"named tuple tests", ^{
    context(@"without generic", ^{
        context(@"ordinal property", ^{
            it(@"can access tuple using properties", ^{
                TestNamedTuple *namedTuple = [[TestNamedTuple alloc] initWithFirst:@"str" second:@1 third:@{@"a": @"b"}];
                
                expect(namedTuple.string).to.equal(@"str");
                expect(namedTuple.number).to.equal(@1);
                expect(namedTuple.dictionary).to.equal(@{@"a": @"b"});
                expect(namedTuple.first).to.equal(namedTuple.string);
                expect(namedTuple.second).to.equal(namedTuple.number);
                expect(namedTuple.third).to.equal(namedTuple.dictionary);
                expect(namedTuple.last).to.equal(namedTuple.dictionary);
                
                namedTuple.string = @"another";
                expect(namedTuple.string).to.equal(@"another");
                
                namedTuple.last = @{@"key": @"value2"};
                expect(namedTuple.dictionary).to.equal(@{@"key": @"value2"});
            });
            
            it(@"can create a new tuple using macro", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect(namedTuple.string).to.equal(@"str");
                expect(namedTuple.number).to.equal(@1);
                expect(namedTuple.dictionary).to.equal(@{@"a": @"b"});
            });
            
            it(@"can unpack tuple using macro", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                EZTupleUnpack(NSString *a, NSNumber *b, NSDictionary *c, EZT_FromVar(namedTuple));
                
                expect(a).to.equal(@"str");
                expect(b).to.equal(@1);
                expect(c).to.equal(@{@"a": @"b"});
            });
            
            it(@"can invoke KVO", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                id observer = mock(NSObject.class);
                
                [namedTuple addObserver:observer
                             forKeyPath:@"number"
                                options:NSKeyValueObservingOptionNew
                                context:NULL];
                
                namedTuple.number = @5;
                
                [verifyCount(observer, times(1)) observeValueForKeyPath:@"number"
                                                               ofObject:namedTuple
                                                                 change:@{NSKeyValueChangeNewKey: @5,
                                                                          NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)}
                                                                context:NULL];
                
                [namedTuple removeObserver:observer forKeyPath:@"number"];
            });
            
            it(@"can observe named property, ordinal property, or property named last, will invoke observe callback when set the named oproperty", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                id observer1 = mock(NSObject.class);
                id observer2 = mock(NSObject.class);
                id observer3 = mock(NSObject.class);
                
                [namedTuple addObserver:observer1
                             forKeyPath:@"last"
                                options:NSKeyValueObservingOptionNew
                                context:NULL];
                
                [namedTuple addObserver:observer2
                             forKeyPath:@"third"
                                options:NSKeyValueObservingOptionNew
                                context:NULL];
                
                [namedTuple addObserver:observer3
                             forKeyPath:@"dictionary"
                                options:NSKeyValueObservingOptionNew
                                context:NULL];
                
                namedTuple.dictionary = @{@"a": @"c"};
                
                [verifyCount(observer1, times(1)) observeValueForKeyPath:@"last"
                                                                ofObject:namedTuple
                                                                  change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                           NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                           }
                                                                 context:NULL];
                
                [verifyCount(observer2, times(1)) observeValueForKeyPath:@"third"
                                                                ofObject:namedTuple
                                                                  change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                           NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                           }
                                                                 context:NULL];
                
                [verifyCount(observer3, times(1)) observeValueForKeyPath:@"dictionary"
                                                                ofObject:namedTuple
                                                                  change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                           NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                           }
                                                                 context:NULL];
                
                [namedTuple removeObserver:observer1 forKeyPath:@"last"];
                [namedTuple removeObserver:observer2 forKeyPath:@"third"];
                [namedTuple removeObserver:observer3 forKeyPath:@"dictionary"];
            });
        });
        
        it(@"can observe named property, ordinal property, or property named last, will invoke observe callback when set the ordinal oproperty", ^{
            TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
            
            id observer1 = mock(NSObject.class);
            id observer2 = mock(NSObject.class);
            id observer3 = mock(NSObject.class);
            
            [namedTuple addObserver:observer1
                         forKeyPath:@"last"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            
            [namedTuple addObserver:observer2
                         forKeyPath:@"third"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            
            [namedTuple addObserver:observer3
                         forKeyPath:@"dictionary"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            
            namedTuple.third = @{@"a": @"c"};
            
            [verifyCount(observer1, times(1)) observeValueForKeyPath:@"last"
                                                            ofObject:namedTuple
                                                              change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                       NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                       }
                                                             context:NULL];
            
            [verifyCount(observer2, times(1)) observeValueForKeyPath:@"third"
                                                            ofObject:namedTuple
                                                              change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                       NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                       }
                                                             context:NULL];
            
            [verifyCount(observer3, times(1)) observeValueForKeyPath:@"dictionary"
                                                            ofObject:namedTuple
                                                              change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                       NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                       }
                                                             context:NULL];
            
            [namedTuple removeObserver:observer1 forKeyPath:@"last"];
            [namedTuple removeObserver:observer2 forKeyPath:@"third"];
            [namedTuple removeObserver:observer3 forKeyPath:@"dictionary"];
        });
        
        it(@"can observe named property, ordinal property, or property named last, will invoke observe callback when set the oproperty named last", ^{
            TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
            
            id observer1 = mock(NSObject.class);
            id observer2 = mock(NSObject.class);
            id observer3 = mock(NSObject.class);
            
            [namedTuple addObserver:observer1
                         forKeyPath:@"last"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            
            [namedTuple addObserver:observer2
                         forKeyPath:@"third"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            
            [namedTuple addObserver:observer3
                         forKeyPath:@"dictionary"
                            options:NSKeyValueObservingOptionNew
                            context:NULL];
            
            namedTuple.last = @{@"a": @"c"};
            
            [verifyCount(observer1, times(1)) observeValueForKeyPath:@"last"
                                                            ofObject:namedTuple
                                                              change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                       NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                       }
                                                             context:NULL];
            
            [verifyCount(observer2, times(1)) observeValueForKeyPath:@"third"
                                                            ofObject:namedTuple
                                                              change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                       NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                       }
                                                             context:NULL];
            
            [verifyCount(observer3, times(1)) observeValueForKeyPath:@"dictionary"
                                                            ofObject:namedTuple
                                                              change:@{NSKeyValueChangeNewKey: @{@"a": @"c"},
                                                                       NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                       }
                                                             context:NULL];
            
            [namedTuple removeObserver:observer1 forKeyPath:@"last"];
            [namedTuple removeObserver:observer2 forKeyPath:@"third"];
            [namedTuple removeObserver:observer3 forKeyPath:@"dictionary"];
        });
        
        context(@"subscript", ^{
            it(@"can access subscript", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect(namedTuple[0]).to.equal(@"str");
                expect(namedTuple[1]).to.equal(@1);
                expect(namedTuple[2]).to.equal(@{@"a": @"b"});
                
                namedTuple[1] = @4;
                
                expect(namedTuple.number).to.equal(@4);
            });
            
            it(@"can invoke KVO using subscript", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                id observer = mock(NSObject.class);
                
                [namedTuple addObserver:observer
                             forKeyPath:@"number"
                                options:NSKeyValueObservingOptionNew
                                context:NULL];
                
                namedTuple[1] = @5;
                
                [verifyCount(observer, times(1)) observeValueForKeyPath:@"number"
                                                               ofObject:namedTuple
                                                                 change:@{NSKeyValueChangeNewKey: @5,
                                                                          NSKeyValueChangeKindKey: @(NSKeyValueChangeSetting)
                                                                          }
                                                                context:NULL];
                
                [namedTuple removeObserver:observer forKeyPath:@"number"];
            });
            
            it(@"will raise an assert if access over subscript", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                id assertHandler = mock(NSAssertionHandler.class);
                
                [[[NSThread currentThread] threadDictionary] setValue:assertHandler
                                                               forKey:NSAssertionHandlerKey];
                
                id any __attribute((unused)) = namedTuple[3];
                
                [[verify(assertHandler) withMatcher:anything()
                                       forArgument:3]
                 handleFailureInMethod:@selector(objectAtIndexedSubscript:)
                 object:namedTuple
                 file:anything()
                 lineNumber:0
                 description:@"Invalid parameter not satisfying: %@", @"%@"];
                
                namedTuple[4] = @5;
                
                [[verify(assertHandler) withMatcher:anything()
                                        forArgument:3]
                 handleFailureInMethod:@selector(setObject:atIndexedSubscript:)
                 object:namedTuple
                 file:anything()
                 lineNumber:0
                 description:@"Invalid parameter not satisfying: %@", @"%@"];
                
                [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];
            });
        });
        
        context(@"fast enumeration", ^{
            it(@"can use for in to access tuple", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                NSMutableArray *array = [NSMutableArray array];
                
                for (id item in namedTuple) {
                    [array addObject:item];
                }
                expect(array).to.equal(@[@"str", @1, @{@"a": @"b"}]);
            });
            
            it(@"can use for(;;) to access tuple", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                NSMutableArray *array = [NSMutableArray array];
                
                for (int i = 0; i < namedTuple.count; i++) {
                    [array addObject:namedTuple[i]];
                }
                
                expect(array).to.equal(@[@"str", @1, @{@"a": @"b"}]);
            });
            
            it(@"can access nil item use for-in", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, nil);
                
                NSMutableArray *array = [NSMutableArray array];
                
                for (id item in namedTuple) {
                    if (item == nil) {
                        [array addObject:NSNull.null];
                    } else {
                        [array addObject:item];
                    }
                }
                expect(array).to.equal(@[@"str", @1, NSNull.null]);
            });
            
            it(@"will raise error if modify any item when enumeration", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                objc_setEnumerationMutationHandler(enumerationMutationHandler);
                
                for(id item in namedTuple) {
                    id useless __attribute((unused)) = item;
                    namedTuple.number = @5;
                }
                
                expect([[NSThread currentThread] threadDictionary][@"mutationErrorObject"]).to.equal(namedTuple);
                [[NSThread currentThread] threadDictionary][@"mutationErrorObject"] = nil;
                
                objc_setEnumerationMutationHandler(NULL);
            });
        });
        
        context(@"copy", ^{
            it(@"can copy to get a cloned one", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                TestNamedTuple *namedTupleCopied = [namedTuple copy];
                
                expect(namedTupleCopied.string).to.equal(@"str");
                expect(namedTupleCopied.number).to.equal(@1);
                expect(namedTupleCopied.dictionary).to.equal(@{@"a": @"b"});
                
                namedTuple.number = @4;
                expect(namedTupleCopied.number).notTo.equal(@4);
            });
        });
        
        context(@"join", ^{
            it(@"can join two tuples use method join:", ^{
                TestNamedTuple *namedTuple1 = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                TestNamedTuple *namedTuple2 = makeTestNamedTuple(@"hello", @2, @{});
                
                expect([namedTuple1 join:namedTuple2]).to.equal(EZTuple(@"str", @1, @{@"a": @"b"}, @"hello", @2, @{}));
            });
            
            it(@"can use extend macro add some new item to exist tuple", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                EZTuple5 *tuple = EZTupleExtend(namedTuple, @4, @5);
                
                expect(tuple).to.equal(EZTuple(@"str", @1, @{@"a": @"b"}, @4, @5));
            });
        });
        
        context(@"take & drop", ^{
            it(@"can take first N item from tuple", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect([namedTuple take:2]).to.equal(EZTuple(@"str", @1));
            });
            
            it(@"should get a clone if taken N is larger than tuple's count", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect([namedTuple take:7]).to.equal(EZTuple(@"str", @1, @{@"a": @"b"}));
            });
            
            it(@"should raise an assert if N is 0", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                id assertHandler = mock(NSAssertionHandler.class);
                
                [[[NSThread currentThread] threadDictionary] setValue:assertHandler
                                                               forKey:NSAssertionHandlerKey];
                
                EZTupleBase *tuple2 = [namedTuple take:0];
                expect(tuple2).to.beNil();
                [[verify(assertHandler) withMatcher:anything()
                                        forArgument:3]
                 handleFailureInMethod:@selector(take:)
                 object:namedTuple
                 file:anything()
                 lineNumber:0
                 description:@"Invalid parameter not satisfying: %@", @"count >= 1 && count <= tupleCountWithObject(self)"];
                
                
                [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];
            });
            
            it(@"can drop first N itme from tuple", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect([namedTuple drop:1]).to.equal(EZTuple(@1, @{@"a": @"b"}));
            });
            
            it(@"should raise an assert if N is larger or equal than tuple's count", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                id assertHandler = mock(NSAssertionHandler.class);
                
                [[[NSThread currentThread] threadDictionary] setValue:assertHandler
                                                               forKey:NSAssertionHandlerKey];
                
                EZTupleBase *tuple2 = [namedTuple drop:11];
                expect(tuple2).to.beNil();
                [[verify(assertHandler) withMatcher:anything()
                                        forArgument:3]
                 handleFailureInMethod:@selector(drop:)
                 object:namedTuple
                 file:anything()
                 lineNumber:0
                 description:@"Invalid parameter not satisfying: %@", @"count < selfCount"];
                
                
                [[[NSThread currentThread] threadDictionary] removeObjectForKey:NSAssertionHandlerKey];
            });
            
            it(@"should get a clone if drop N is zero", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect([namedTuple drop:0]).to.equal(EZTuple(@"str", @1, @{@"a": @"b"}));
            });
        });
        
        context(@"tuple and array convert", ^{
            it(@"can convert a tuple to an array", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect([namedTuple allObjects]).to.equal(@[@"str", @1, @{@"a": @"b"}]);
            });
            
            it(@"should use NSNull instead nil when convert to an array", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", nil, @{@"a": @"b"});
                
                expect([namedTuple allObjects]).to.equal(@[@"str", NSNull.null, @{@"a": @"b"}]);
            });
            
            it(@"can convert an array to a tuple", ^{
                TestNamedTuple *namedTuple = [TestNamedTuple tupleWithArray:@[@"str", @1, @{@"a": @"b"}]];
                
                expect(namedTuple).to.equal(makeTestNamedTuple(@"str", @1, @{@"a": @"b"}));
            });
            
            it(@"should use nil instead NSNull when convert to a tuple", ^{
                TestNamedTuple *namedTuple = [TestNamedTuple tupleWithArray:@[@"str", NSNull.null, @{@"a": @"b"}]];
                
                expect(namedTuple).to.equal(makeTestNamedTuple(@"str", nil, @{@"a": @"b"}));
            });
        });
        
        context(@"others", ^{
            it(@"will show description like NSArray", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, @{@"a": @"b"});
                
                expect(namedTuple.description).to.equal([NSString stringWithFormat:@"<TestNamedTuple: %p>(\n\tstring = str;\n\tnumber = 1;\n\tdictionary = {\n    a = b;\n};\n)", namedTuple]);
            });
            
            it(@"will show nil as null", ^{
                TestNamedTuple *namedTuple = makeTestNamedTuple(@"str", @1, nil);
                
                expect(namedTuple.description).to.equal([NSString stringWithFormat:@"<TestNamedTuple: %p>(\n\tstring = str;\n\tnumber = 1;\n\tdictionary = nil;\n)", namedTuple]);
            });
        });
    });

    context(@"with generic", ^{
        it(@"can create a generic named tuple", ^{
            TestNamedTupleWithGeneric<NSNumber *, NSString *, NSString *> *generic = makeTestNamedTupleWithGeneric(@[@1, @2, @3], @{@"a": @"b", @"c": @"d"});
            expect(generic.arr).to.equal(@[@1, @2, @3]);
            expect(generic.arr.lastObject.stringValue).to.equal(@"3");
            expect(generic.dic).to.equal(@{@"a": @"b", @"c": @"d"});
            expect(generic.dic[@"c"].uppercaseString).to.equal(@"D");
        });
    });
});

SpecEnd
