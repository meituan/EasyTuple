<p align="center">
	<a href="https://github.com/meituan/EasyTuple"><img src="Logo/logo.png" alt="EasyTuple" /></a>
</p>
<br />

[![Build Status](https://travis-ci.org/meituan/EasyTuple.svg?branch=master)](https://travis-ci.org/meituan/EasyTuple)
[![Version](https://img.shields.io/cocoapods/v/EasyTuple.svg?style=flat)](http://cocoapods.org/pods/EasyTuple)
[![License](https://img.shields.io/cocoapods/l/EasyTuple.svg?style=flat)](http://cocoapods.org/pods/EasyTuple)
[![Platform](https://img.shields.io/cocoapods/p/EasyTuple.svg?style=flat)](http://cocoapods.org/pods/EasyTuple)

## Why you need it

Sometimes you may need to return multiple values other than just one. In these cases, you can use a pointer, like `NSError **`, or you can put them into an array or a dictionary, or straightforward, create a class for it. But you have another choice now, EasyTuple, it can group multiple values in a better way.

## How to use it

You can use the macro `EZTuple` to create a tuple, and it supports generics. Like this:

```objective-c
EZTuple3<NSNumber *, NSString *, NSDictionary> *tuple = EZTuple(@1, @"string", nil);
```

`EZTuple3` means there are 3 items in this tuple. So `EZTuple6` is 6 item. There are 20 classes from `EZTuple1` to `EZTuple20` support you to use.

The maximum capacity of EZTuple is 20. It is big enough in most cases. If you really need something larger than that, an array or a dictionary might be a better choice at the moment.

You have serval ways to get and set values:

```objective-c
EZTuple3<NSNumber *, NSString *, NSDictionary> *tuple = EZTuple(@1, @"string", nil);
// use the unpack macro
EZTupleUnpack(NSNumber *a, NSString *b, NSDictionary *c, EZT_FromVar(tuple));
NSLog(@"first:%@, second:%@, last:%@", a, b, c);
// use ordinal numbers like first, second
tuple.first;
tuple.first = @5;
// use last
tuple.last;
tuple.last = @"last";
// use subscript
tuple[0];
tuple[0] = @"s";
// iteration
BOOL hasNil = NO;
for (id value in tuple) {
    NSLog(@"%@", value);
    if (value == nil) hasNil = YES;
    tuple.first = @3 // will throw an exception!
}
// hasNil -> YES
```

The `last`of the tuple is an alias of the "last element", in the sample code above, it is equivalent to `second`.

All the elements inside the tuple are Key-Value Observable. If you observe `second` and `last`, both callbacks will be invoked if you changed `second` (or `last`).

EZTuple supports `NSCopying` protocol. You can easily copy them if you need.

## Named tuples

The tuple classes from `EZTuple1` to `EZTuple20` only have properties `first`, `second`, etc. You may need to give the properties custom names. Named tuple can help you.

Each named tuple is a class. So you may declare it like this:

```objective-c
// File TestNamedTuple.h or the other header

@import EasyTuple;

// Define a macro table with your tuple name concating 'Table'
#define TestNamedTupleTable(_) \
_(NSString *, string) \
_(NSNumber *, number) \
_(NSDictionary *, dictionary)

// Declare your class which is your tuple name
EZTNamedTupleDef(TestNamedTuple)
```

You should implement the class because it is a real class. You may implement it like this:

```objective-c
// File TestNamedTuple.m or the other .m file
#import "TestNamedTuple.h"

// Implement your class
EZTNamedTupleImp(TestNamedTuple)
```

Now you can use your named tuple like a normal class:

```objective-c

- (void)anyMethod {
    TestNamedTuple *tuple = TestNamedTupleMake(@"str", @15, @{@"key": @"value"});
    tuple.string = @"new";
    NSLog(@"property number is %@", tuple.number);
}

```

There is generic inside the property type? Don't worry, it can support like this:

```objective-c
#define TestNamedTupleWithGenericTable(_) \
_(NSArray<T> *, arr) \
_(NSDictionary<K, V> *, dic);

EZTNamedTupleDef(TestNamedTupleWithGeneric, T, K, V)

```

## Features

* [x] EZTuple macro create a tuple quickly
* [x] ordinal number properties
* [x] subscripts accessing
* [x] for-in accessing
* [x] NSScopy protocol supporting
* [x] drop some item or take some item
* [x] join two tuples
* [x] convert a tuple to an array or convert an array to a tuple
* [x] declare named tuple

## Advantages

Compare to NSArray / NSDictionary, EZTuple has the following advantages:

* Supports generics for EACH element
* Key-Value Observable
* Supports `nil`
* Access elements via ordinal numbers and `last`

## Acknowledgement

This library is highly inspired by the macro techniques in libextobjc.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EasyTuple is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EasyTuple"
```

## Author

WilliamZang, chengwei.zang.1985@gmail.com

JohnnyWu, johnny.wjy07@gmail.com

ValiantCat, 519224747@qq.com

## License

EasyTuple is available under the MIT license. See the LICENSE file for more info.
