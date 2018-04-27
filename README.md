# EasyTuple

[![CI Status](http://img.shields.io/travis/WilliamZang/EasyTuple.svg?style=flat)](https://travis-ci.org/WilliamZang/EasyTuple)
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

## Features

* EZTuple macro create a tuple quickly
* ordinal number properties
* subscripts accessing
* for-in accessing
* NSScopy protocol supporting
* drop some item or take some item
* join two tuples
* convert a tuple to an array or convert an array to a tuple

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



## License

EasyTuple is available under the MIT license. See the LICENSE file for more info.
